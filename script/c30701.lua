--超次元跃迁战列舰
function c30701.initial_effect(c)
	c:EnableReviveLimit()
	aux.EnablePendulumAttribute(c,false)
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(c30701.mfilter),9,2,nil,nil,5)	
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(30701,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c30701.thcost)
	e2:SetTarget(c30701.target)
	e2:SetOperation(c30701.activate)
	c:RegisterEffect(e2)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30701,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c30701.cost)
	e1:SetTarget(c30701.mttg)
	e1:SetOperation(c30701.mtop)
	c:RegisterEffect(e1)
	--Cost
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_CHAINING)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCondition(c30701.condition)
	e8:SetOperation(c30701.cost2)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetCode(EFFECT_CANNOT_ACTIVATE)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetRange(LOCATION_MZONE)
	e9:SetTargetRange(1,1)
	e9:SetCondition(c30701.accon)
	e9:SetValue(c30701.actlimit)
	c:RegisterEffect(e9)
end
function c30701.mfilter(c)
	return not c:IsRace(RACE_DRAGON) and not c:IsRace(RACE_FAIRY)
end
function c30701.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c30701.sfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c30701.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30701.sfilter,tp,LOCATION_DECK,0,1,nil) 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	e:SetLabel(e:GetHandler():GetSequence())
end
function c30701.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c30701.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
		Duel.ConfirmCards(1-tp,g)
	end
end
function c30701.filter2(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,c:GetCode())
end
function c30701.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30701.filter2,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.GetMatchingGroup(c30701.filter2,tp,LOCATION_DECK,0,nil)
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoGrave(sg,REASON_COST)
	e:SetLabel(sg:GetFirst():GetCode())
end
function c30701.mtfilter(c,cid)
	return cid==0 or c:IsCode(cid)
end
function c30701.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c30701.mtfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,0) end
end
function c30701.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c30701.mtfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e:GetLabel())
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
function c30701.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsType(TYPE_XYZ)
end
function c30701.cost2(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(1-tp,500)
end
function c30701.accon(e)
	return Duel.GetLP(1-e:GetHandler():GetControler())<=500
end
function c30701.actlimit(e,te,tp)
	return te:GetHandler():IsType(TYPE_XYZ)
end