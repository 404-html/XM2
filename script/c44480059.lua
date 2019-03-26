--蓝瞳器·苏生之羽
function c44480059.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480059,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44480059+EFFECT_COUNT_CODE_OATH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c44480059.target)
	e1:SetOperation(c44480059.operation)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--equip
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44480059,1))
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetCountLimit(1,0x647)
	e11:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e11:SetCost(c44480059.cost)
	e11:SetTarget(c44480059.eqtg)
	e11:SetOperation(c44480059.eqop)
	c:RegisterEffect(e11)
	--atk
	local e20=Effect.CreateEffect(c)
	e20:SetType(EFFECT_TYPE_EQUIP)
	e20:SetCode(EFFECT_UPDATE_ATTACK)
	e20:SetValue(100)
	c:RegisterEffect(e20)
	--Equip limit
	local e21=Effect.CreateEffect(c)
	e21:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e21:SetType(EFFECT_TYPE_SINGLE)
	e21:SetCode(EFFECT_EQUIP_LIMIT)
	e21:SetValue(1)
	c:RegisterEffect(e21)
end

function c44480059.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c44480059.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c44480059.costfilter(c)
	return c:IsDiscardable()
end
function c44480059.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480059.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c44480059.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c44480059.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0x646)
end
function c44480059.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c44480059.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c44480059.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c44480059.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c44480059.eqlimit(e,c)
	return e:GetLabelObject()==c
end
function c44480059.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)==0 then return end
		Duel.Equip(tp,c,tc)
		--Add Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c44480059.eqlimit)
		e1:SetLabelObject(tc)
		c:RegisterEffect(e1)
	end
end