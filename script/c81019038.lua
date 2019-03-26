--花与秋千
function c81019038.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_RECOVER)
	e1:SetCountLimit(1,81019038+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c81019038.condition)
	e1:SetTarget(c81019038.target)
	e1:SetOperation(c81019038.activate)
	c:RegisterEffect(e1)
end
function c81019038.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c81019038.filter(c,e,tp,ev)
	return c:IsSetCard(0xc9) and c:IsAttackBelow(ev) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c81019038.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c81019038.filter,tp,LOCATION_DECK,0,1,nil,e,tp,ev) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c81019038.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c81019038.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp,ev)
	local tc=g:GetFirst()
	if g:GetCount()>0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		Duel.Recover(tp,tc:GetBaseDefense(),REASON_EFFECT)
	end
end
