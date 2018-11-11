--百夜·零之颂葬者
function c44448001.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44448001.matfilter,1)
	--sum
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44448001,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,44448001)
	e2:SetCost(c44448001.cost)
	e2:SetTarget(c44448001.target)
	e2:SetOperation(c44448001.operation)
	c:RegisterEffect(e2)
	--to grave
	local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(44448001,1))
	e22:SetCategory(CATEGORY_TOGRAVE)
	e22:SetType(EFFECT_TYPE_IGNITION)
	e22:SetRange(LOCATION_GRAVE)
	e22:SetCountLimit(1,44448011)
	e22:SetCost(aux.bfgcost)
	e22:SetTarget(c44448001.tgtg)
	e22:SetOperation(c44448001.tgop)
	c:RegisterEffect(e22)
end
function c44448001.matfilter(c)
	return c:IsLinkAttribute(ATTRIBUTE_WATER) and not c:IsLinkCode(44448001)
end
function c44448001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c44448001.filter(c)
	return c:IsSummonable(true,e) and c:IsAbleToHand() and c:IsLevelBelow(4) and c:IsType(TYPE_NORMAL)
end
function c44448001.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c44448001.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44448001.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c44448001.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c44448001.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		if tc:IsSummonable(true,nil) then
			Duel.Summon(tp,tc,true,nil)
		end
	end
end
--to grave
function c44448001.tgfilter(c)
	return c:IsSetCard(0x644) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGrave()
end
function c44448001.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44448001.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c44448001.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c44448001.tgfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>=1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end