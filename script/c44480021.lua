--瞳器-虚化显像
function c44480021.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCountLimit(1,44480021)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c44480021.pcost)
	e1:SetTarget(c44480021.target)
	e1:SetOperation(c44480021.activate)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44480021,0))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,44480121)
	e2:SetCondition(aux.exccon)
	e2:SetCost(c44480021.cost1)
	e2:SetTarget(c44480021.target1)
	e2:SetOperation(c44480021.operation1)
	--e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
--ds deck
function c44480021.cfilter(c)
	return c:IsFaceup() and c:IsAbleToHandAsCost() and c:IsSetCard(0x646)
end
function c44480021.pcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480021.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c44480021.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_COST)
end
function c44480021.dkfilter(c)
	return c:IsSetCard(0x646)
end
function c44480021.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480021.dkfilter,tp,LOCATION_DECK,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c44480021.dkfilter,tp,LOCATION_DECK,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c44480021.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c44480021.dkfilter,tp,LOCATION_DECK,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
--summon
function c44480021.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c44480021.filter(c,e)
	return c:IsSetCard(0x646) and c:IsSummonable(true,e)
end
function c44480021.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c44480021.filter,tp,LOCATION_HAND,0,1,nil,e) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c44480021.operation1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c44480021.filter,tp,LOCATION_HAND,0,1,1,nil,e)
	local tc=g:GetFirst()
	local se=e:GetLabelObject()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(44480021,1))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetReset(RESET_EVENT+RESET_TOFIELD)
	e1:SetCondition(c44480021.ntcon)
	if tc then
		tc:RegisterEffect(e1)
		Duel.Summon(tp,tc,true,se)
	end
end
function c44480021.ntcon(e,c)
	if c==nil then return true end
	return c:GetLevel()>0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end