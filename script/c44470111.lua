--黑皇后
function c44470111.initial_effect(c)
	--normal monster
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_HAND)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_ADD_ATTRIBUTE)
	e3:SetValue(ATTRIBUTE_FIRE)
	c:RegisterEffect(e3)
	--ToGeave
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(44470111,1))
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_REMOVE)
	e4:SetCountLimit(1,44471111)
	e4:SetTarget(c44470111.tgtg)
	e4:SetOperation(c44470111.tgop)
	c:RegisterEffect(e4)
	--summon
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(44470111,0))
	e12:SetCountLimit(1,44470111)
	e12:SetCategory(CATEGORY_SUMMON)
	e12:SetType(EFFECT_TYPE_IGNITION)
	e12:SetRange(LOCATION_HAND)
    e12:SetCost(c44470111.cost)
	e12:SetTarget(c44470111.target)
	e12:SetOperation(c44470111.operation)
	c:RegisterEffect(e12)
end
--速攻召唤
function c44470111.cfilter(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_MONSTER) and c:GetLevel()==7
end
function c44470111.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470111.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g1=Duel.SelectMatchingCard(tp,c44470111.cfilter,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.ConfirmCards(1-tp,g1)
	Duel.ShuffleHand(tp)
end
function c44470111.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,e:GetHandler(),1,0,0)
end
function c44470111.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--local se=e:GetLabelObject()
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44470111,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetReset(RESET_EVENT+RESET_TOFIELD)
	e1:SetCondition(c44470111.ntcon)
	c:RegisterEffect(e1)
	if c:IsSummonable(true,nil) then
	
	Duel.Summon(tp,c,true,nil)
	end
end
function c44470111.ntcon(e,c)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
--ToGeave
function c44470111.tgfilter(c)
	return c:GetAttack()==2400 and c:IsAbleToGrave() and c:GetLevel()==7
end
function c44470111.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470111.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c44470111.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44470111.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_GRAVE) and tc:IsType(TYPE_NORMAL)
		and Duel.IsExistingMatchingCard(c44470111.tgfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(44470111,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,c44470111.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(g1,REASON_EFFECT)
	end
end