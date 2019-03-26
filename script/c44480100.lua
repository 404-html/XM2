--瞳器系谱
function c44480100.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	--remain field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e3)
	--equip
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44480100,0))
	e11:SetCategory(CATEGORY_EQUIP)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e11:SetProperty(EFFECT_FLAG_DELAY)
	e11:SetCode(EVENT_SUMMON_SUCCESS)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--e11:SetCountLimit(1,44480100)
	e11:SetRange(LOCATION_SZONE)
	e11:SetCondition(c44480100.eqcon)
	--e11:SetCost(c44480100.eqcost)
	e11:SetTarget(c44480100.eqtg)
	e11:SetOperation(c44480100.eqop)
	c:RegisterEffect(e11)
	local e21=e11:Clone()
	e21:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e21)
end
function c44480100.filter2(c,tp)
	return c:IsControler(1-tp)
end
function c44480100.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x646)
	and c:IsType(TYPE_MONSTER)
end
function c44480100.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44480100.filter2,1,nil,tp)
    --and Duel.IsExistingMatchingCard(c44480100.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c44480100.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x646)
end
function c44480100.eqfilter(c,tp)
	return c:CheckUniqueOnField(tp) and c:IsType(TYPE_SPELL+TYPE_TRAP)
    and c:IsSetCard(0x646)
	and not c:IsForbidden()
	and not c:IsSetCard(0x649)
	and not c:IsSetCard(0x648)
end
function c44480100.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c44480100.filter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c44480100.filter,tp,LOCATION_MZONE,0,1,c)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c44480100.eqfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44480100.filter,tp,LOCATION_MZONE,0,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c44480100.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local ec=Duel.SelectMatchingCard(tp,c44480100.eqfilter,tp,LOCATION_HAND+LOCATION_GRAVE,LOCATION_HAND+LOCATION_GRAVE,1,1,nil,tp):GetFirst()
	if ec then
		Duel.Equip(tp,ec,tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c44480100.eqlimit)
		e1:SetLabelObject(tc)
		ec:RegisterEffect(e1)
	end
end
function c44480100.eqlimit(e,c)
	return c==e:GetLabelObject()
end