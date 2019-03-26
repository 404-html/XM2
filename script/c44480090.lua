--瞳器·片剪太刀
function c44480090.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480090,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetCountLimit(1,44480090+EFFECT_COUNT_CODE_OATH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e0+TIMING_END_PHASE)
	e1:SetTarget(c44480090.eqtg)
	e1:SetOperation(c44480090.eqop)
	c:RegisterEffect(e1)
	--atk
	local e20=Effect.CreateEffect(c)
	e20:SetType(EFFECT_TYPE_EQUIP)
	e20:SetCode(EFFECT_UPDATE_ATTACK)
	e20:SetValue(200)
	c:RegisterEffect(e20)
	--disable
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_EQUIP)
	e21:SetCode(EFFECT_DISABLE)
	--e21:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e21)
	--negate
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e22:SetCode(EVENT_ATTACK_ANNOUNCE)
	e22:SetRange(LOCATION_SZONE)
	e22:SetCondition(c44480090.negcon1)
	e22:SetOperation(c44480090.negop1)
	c:RegisterEffect(e22)
	local e32=Effect.CreateEffect(c)
	e32:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e32:SetCode(EVENT_BE_BATTLE_TARGET)
	e32:SetRange(LOCATION_SZONE)
	e32:SetCondition(c44480090.negcon2)
	e32:SetOperation(c44480090.negop2)
	c:RegisterEffect(e32)

end
--equip
function c44480090.filter(c)
	return c:IsFaceup() 
end
function c44480090.eqfilter(c,tp)
	return c:CheckUniqueOnField(tp) and c:IsType(TYPE_SPELL+TYPE_TRAP)
    and c:IsSetCard(0x646)
	and not c:IsForbidden()
end
function c44480090.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c44480090.filter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c44480090.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>1
		and Duel.IsExistingMatchingCard(c44480090.eqfilter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44480090.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_DECK)
end
function c44480090.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=1 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local ec=Duel.SelectMatchingCard(tp,c44480090.eqfilter,tp,LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	if ec then
		Duel.Equip(tp,ec,tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c44480090.eqlimit)
		e1:SetLabelObject(tc)
		ec:RegisterEffect(e1)
	end
end
function c44480090.eqlimit(e,c)
	return c==e:GetLabelObject()
end

function c44480090.negcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()==Duel.GetAttacker()
end
function c44480090.negop1(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d~=nil then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		d:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		d:RegisterEffect(e2)
	end
end
function c44480090.negcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()==Duel.GetAttackTarget()
end
function c44480090.negop2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a~=nil then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		a:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		a:RegisterEffect(e2)
	end
end