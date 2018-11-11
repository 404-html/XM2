--妖术
function c32880115.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c32880115.cost)
	e1:SetCondition(c32880115.actcon)
	e1:SetOperation(c32880115.operation)
	c:RegisterEffect(e1)
end
function c32880115.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,4,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,4,REASON_COST)
end
function c32880115.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x744)
end
function c32880115.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880232.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880115.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	if Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)>0 then
	   if Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
		  and Duel.IsPlayerCanSpecialSummonMonster(tp,32880116,0x730,0x4011,0,500,1,RACE_BEAST,ATTRIBUTE_WATER,POS_FACEUP,1-tp) then
		  local token=Duel.CreateToken(tp,32880116)
		  if Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP) then 
			 local e1=Effect.CreateEffect(e:GetHandler()) 
			 e1:SetType(EFFECT_TYPE_FIELD)
			 e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
			 e1:SetRange(LOCATION_MZONE)
			 e1:SetTargetRange(0,LOCATION_MZONE)
			 e1:SetCondition(c32880115.atcon)
			 e1:SetValue(c32880115.atlimit)
			 token:RegisterEffect(e1,true)
		  end
		  Duel.SpecialSummonComplete()
	   end
	end
end
function c32880115.atcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP)
end
function c32880115.atlimit(e,c)
	return c~=e:GetHandler() 
end