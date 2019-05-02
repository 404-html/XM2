--红瞳器·血屠尺
function c44480079.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480079,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetCountLimit(1,44480079+EFFECT_COUNT_CODE_OATH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0+TIMING_END_PHASE)
	e1:SetTarget(c44480079.eqtg)
	e1:SetOperation(c44480079.eqop)
	c:RegisterEffect(e1)
	--damage chain atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44480079,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCategory(CATEGORY_DAMAGE)
	--e2:SetCountLimit(1,44480079)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c44480079.dbcon)
	e2:SetTarget(c44480079.dbtg)
	e2:SetOperation(c44480079.atkop)
	c:RegisterEffect(e2)
	--atk
	local e20=Effect.CreateEffect(c)
	e20:SetType(EFFECT_TYPE_EQUIP)
	e20:SetCode(EFFECT_UPDATE_ATTACK)
	e20:SetCondition(c44480079.descon)
	e20:SetValue(500)
	c:RegisterEffect(e20)
	--disable
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_EQUIP)
	e21:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e21)
end
--equip
function c44480079.filter(c)
	return c:IsFaceup() 
end
function c44480079.eqfilter(c,tp)
	return c:CheckUniqueOnField(tp) and c:IsType(TYPE_SPELL+TYPE_TRAP)
    and c:IsSetCard(0x646)
	and not c:IsForbidden()
end
function c44480079.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c44480079.filter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c44480079.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c44480079.eqfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44480079.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c44480079.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=1 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local ec=Duel.SelectMatchingCard(tp,c44480079.eqfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
	if ec then
		Duel.Equip(tp,ec,tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c44480079.eqlimit)
		e1:SetLabelObject(tc)
		ec:RegisterEffect(e1)
	end
end
function c44480079.eqlimit(e,c)
	return c==e:GetLabelObject()
end
--damage
function c44480079.cfilter(c)
	return c:IsFaceup() and c:IsCode(44480079)
end
function c44480079.dbcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	local bc=ec:GetBattleTarget()
	return
	--ec:GetEquipGroup():IsExists(c44480079.cfilter,1,nil) and 
	bc and bc:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c44480079.dbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local atk=e:GetHandler():GetEquipTarget():GetAttack()
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c44480079.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if ec and c:IsRelateToEffect(e) then
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		local d=ec:GetAttack()
		Duel.Damage(p,d,REASON_EFFECT)
	end
end
--atk
function c44480079.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget():IsSetCard(0x645) 
end
