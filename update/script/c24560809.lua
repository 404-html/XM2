--炯阳之瞳
function c24560809.initial_effect(c)
	--spsummmon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetCountLimit(1,24560809+EFFECT_COUNT_CODE_OATH)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCost(c24560809.cost)
	e4:SetTarget(c24560809.tg)
	e4:SetOperation(c24560809.op)
	c:RegisterEffect(e4)	
end
function c24560809.spcfil(c,ft,tp)
	return c:IsCode(24560812)
	and c:GetSequence()==2 
	and c:IsFaceup() 
	and c:GetAttack()>=3000
end
function c24560809.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.CheckReleaseGroup(tp,c24560809.spcfil,1,nil,ft,tp) end
	local sg=Duel.SelectReleaseGroup(tp,c24560809.spcfil,1,1,nil,ft,tp)
	Duel.Release(sg,REASON_COST)
end
function c24560809.fil(c,e,tp)
	return c:IsCode(24560808) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c24560809.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.IsExistingMatchingCard(c24560809.fil,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD+LOCATION_HAND,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK+LOCATION_HAND)
end
function c24560809.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c24560809.fil,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	local g2=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD+LOCATION_HAND,0,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Destroy(g2,REASON_EFFECT)
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end