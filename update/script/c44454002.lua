--化学反应-分解反应
function c44454002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44454002)
	e1:SetTarget(c44454002.target)
	e1:SetOperation(c44454002.activate)
	c:RegisterEffect(e1)
	--Activate2
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44454002,0))
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetRange(LOCATION_GRAVE)
	e11:SetCountLimit(1,44454102)
	e11:SetCost(c44454002.cost)
	e11:SetTarget(c44454002.target)
	e11:SetOperation(c44454002.activate)
	c:RegisterEffect(e11)
end
--Activate2
function c44454002.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
--Activate
function c44454002.gvfilter(c,ft)
	return c:IsSetCard(0x652) and c:IsFaceup() and c:IsAbleToGrave() 
end
function c44454002.filter(c,ft)
	return c:IsSetCard(0x654) and c:IsAbleToGrave()and not c:IsCode(44454002)
end
function c44454002.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44454002.gvfilter(chkc,ft) end
	if chk==0 then return Duel.IsExistingTarget(c44454002.gvfilter,tp,LOCATION_MZONE,0,1,nil,ft) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c44454002.gvfilter,tp,LOCATION_MZONE,0,1,1,nil,ft)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c44454002.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then end
			local g=Duel.GetMatchingGroup(c44454002.filter,tp,LOCATION_DECK,0,nil)
            if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(44454002,1)) then
		        Duel.BreakEffect()
		        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		        local sg=g:Select(tp,1,1,nil)
		        Duel.SendtoGrave(sg,nil,REASON_EFFECT)
	        end
	end
end
