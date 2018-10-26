--猛毒性 积垢
function c24762461.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24762461,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,24762461)
	e1:SetCondition(c24762461.e1con)
	e1:SetCost(c24762461.e1cost)
	e1:SetTarget(c24762461.e1tg)
	e1:SetOperation(c24762461.e1op)
	c:RegisterEffect(e1)
end
function c24762461.e1con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetMatchingGroupCount(c24762461.e1confil,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)>0
end
function c24762461.e1confil(c)
	return c:IsSetCard(0x9390) and c:IsFaceup()
end
function c24762461.e3cfil(c)
	return c:IsSetCard(0x9390) and c:IsAbleToRemoveAsCost()
end
function c24762461.e1cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c24762461.e3cfil,tp,LOCATION_GRAVE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c24762461.e3cfil,tp,LOCATION_GRAVE,0,1,1,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c24762461.e1tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetPlayer(1-tp)
	local dmg=Duel.GetMatchingGroupCount(c24762461.e1confil,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SetTargetParam(dmg*100)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dmg*100)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c24762461.e1op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end