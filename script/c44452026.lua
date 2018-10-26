--化学化合物-硫酸
function c44452026.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
    aux.AddFusionProcCode3(c,44450001,44450016,44450008,true,true)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44452026,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c44452026.con)
	e1:SetTarget(c44452026.tg)
	e1:SetOperation(c44452026.op)
	c:RegisterEffect(e1)
	--tohand
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44452026,1))
	e11:SetCategory(CATEGORY_TODECK)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCountLimit(1)
	e11:SetCost(c44452026.cost)
	e11:SetTarget(c44452026.target)
	e11:SetOperation(c44452026.operation)
	e11:SetHintTiming(0,0x1e0)
	c:RegisterEffect(e11)
end
function c44452026.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c44452026.refilter(c)
	return c:IsAbleToRemove() 
end
function c44452026.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c44452026.refilter,tp,0,LOCATION_GRAVE,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,tp,1)
end
function c44452026.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44452026.refilter,tp,0,LOCATION_GRAVE,3,3,nil)
	Duel.HintSelection(g)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
--tohand
function c44452026.rfilter(c)
	return c:IsAbleToDeckAsCost() 
end
function c44452026.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44452026.rfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	local rg=Duel.SelectMatchingCard(tp,c44452026.rfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.SendtoDeck(rg,nil,2,REASON_EFFECT)
	local rc=rg:GetFirst()
	if rc:IsType(TYPE_SPELL) or rc:IsType(TYPE_TRAP) then e:SetLabel(1)
	elseif rc:IsType(TYPE_MONSTER) then e:SetLabel(2)
	else e:SetLabel(0)
	end
end
function c44452026.thfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c44452026.thfilter1(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c44452026.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,tp,1)
end
function c44452026.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 then 
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g1=Duel.SelectMatchingCard(tp,c44452026.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g1:GetCount()>0 then
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
	    end
	    elseif e:GetLabel()==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	    local g2=Duel.SelectMatchingCard(tp,c44452026.thfilter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	    if g2:GetCount()>0 then
		Duel.SendtoHand(g2,nil,REASON_EFFECT)
		end
	end
end