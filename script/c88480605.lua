--鸽不过三
function c88480605.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c88480605.con)
	e1:SetOperation(c88480605.op)
	c:RegisterEffect(e1)
end
function c88480605.ft(c)
	return c:GetFlagEffect(88480604)>0
end
function c88480605.ft0(c)
	return c:IsCode(88480601) and c:IsAbleToRemove()
end
function c88480605.con(e,tp,eg,ep,ev,re,r,rp)
	local num=Duel.GetMatchingGroupCount(c88480605.ft,tp,0,LOCATION_SZONE,nil)
	local ll=e:GetHandler():GetLocation()
	if ll==LOCATION_SZONE then
		return num>=3 and Duel.GetLocationCount(tp,LOCATION_SZONE)>=num and Duel.IsExistingMatchingCard(c88480605.ft0,tp,LOCATION_DECK,0,1,nil)
	else 
		return num>=3 and Duel.GetLocationCount(tp,LOCATION_SZONE)>=num+1 and Duel.IsExistingMatchingCard(c88480605.ft0,tp,LOCATION_DECK,0,1,nil)
	end
end
function c88480605.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c88480605.ft0,tp,LOCATION_DECK,0,nil)
	g=g:Select(tp,1,1,nil)
	if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)>0 then
		g=Duel.GetMatchingGroup(c88480605.ft,tp,0,LOCATION_SZONE,nil)
		local tc=g:GetFirst()
		local num=1
		while num<=g:GetCount() do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,false)
			tc:RegisterFlagEffect(88480601,RESET_EVENT+RESETS_STANDARD-RESET_TOGRAVE-RESET_LEAVE,0,1)
			num=num+1
			tc=g:GetNext()
		end
	end
end