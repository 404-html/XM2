--化学单质-氖气
function c44450010.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44450010,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
    e1:SetCost(c44450010.spcost)
	e1:SetTarget(c44450010.sptg)
	e1:SetOperation(c44450010.spop)
	c:RegisterEffect(e1)
	--act limit1
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c44450010.chainop1)
	c:RegisterEffect(e3)
	--act limit2
	local e31=Effect.CreateEffect(c)
	e31:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e31:SetCode(EVENT_CHAINING)
	e31:SetRange(LOCATION_MZONE)
	e31:SetCondition(c44450010.condition)
	e31:SetOperation(c44450010.chainop2)
	c:RegisterEffect(e31)
end
function c44450010.filter(c)
	return c:IsAbleToGraveAsCost() and c:IsSetCard(0x652)
end
function c44450010.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44450010.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44450010.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c44450010.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44450010.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
--act limit1
function c44450010.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)<=Duel.GetFieldGroupCount(tp,0,LOCATION_EXTRA)-1
end
function c44450010.chainop1(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsSetCard(0x650) and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then
		Duel.SetChainLimit(c44450010.chainlm1)
	end
end
function c44450010.chainlm1(e,rp,tp)
	return tp==rp or e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--act limit2
function c44450010.chainop2(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsSetCard(0x650) and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then
		Duel.SetChainLimit(c44450010.chainlm2)
	end
end
function c44450010.chainlm2(e,rp,tp)
	return tp==rp or not e:IsHasType(EFFECT_TYPE_ACTIVATE)
end