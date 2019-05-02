--真红眼黯黑龙
function c44470001.initial_effect(c)
	--code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetValue(74677422)
	c:RegisterEffect(e2)   
	--summon
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(44470001,0))
	e12:SetCountLimit(1,44470001)
	e12:SetCategory(CATEGORY_SUMMON)
	e12:SetType(EFFECT_TYPE_IGNITION)
	e12:SetRange(LOCATION_HAND)
    e12:SetCost(c44470001.cost)
	e12:SetTarget(c44470001.target)
	e12:SetOperation(c44470001.operation)
	c:RegisterEffect(e12)
	--tohand
	local e31=Effect.CreateEffect(c)
	e31:SetDescription(aux.Stringid(44470001,1))
	e31:SetCountLimit(1,44471001)
	e31:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e31:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e31:SetCode(EVENT_TO_GRAVE)
	e31:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e31:SetTarget(c44470001.thtg)
	e31:SetOperation(c44470001.thop)
	c:RegisterEffect(e31)
end
--速攻召唤
function c44470001.cfilter(c)
	return c:IsCode(74677422) and c:IsAbleToGraveAsCost()
end
function c44470001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470001.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44470001.cfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c44470001.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,e:GetHandler(),1,0,0)
end
function c44470001.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--local se=e:GetLabelObject()
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44470001,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetReset(RESET_EVENT+RESET_TOFIELD)
	e1:SetCondition(c44470001.ntcon)
	
	c:RegisterEffect(e1)
	if c:IsSummonable(true,nil) then
	Duel.Summon(tp,c,true,nil)
		local e11=Effect.CreateEffect(c)
		e11:SetType(EFFECT_TYPE_SINGLE)
		e11:SetCode(EFFECT_CANNOT_ATTACK)
		e11:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e11,true)
	end
end
function c44470001.ntcon(e,c)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
--tohand
function c44470001.filter(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c44470001.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470001.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44470001.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44470001.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
