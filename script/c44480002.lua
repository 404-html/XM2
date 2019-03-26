--瞳器使·艾尔
function c44480002.initial_effect(c)
	c:SetUniqueOnField(1,0,44480002)
	--ds deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480002,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c44480002.target)
	e1:SetOperation(c44480002.operation)
	c:RegisterEffect(e1)
	--atk1/2
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetCode(EFFECT_SET_BASE_ATTACK)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(1200)
	c:RegisterEffect(e11)
	--2def1/2
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetCode(EFFECT_SET_BASE_DEFENSE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetValue(1200)
	c:RegisterEffect(e12)
end
--ds deck
function c44480002.dkfilter(c)
	return c:IsSetCard(0x647)
end
function c44480002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480002.dkfilter,tp,LOCATION_DECK,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c44480002.dkfilter,tp,LOCATION_DECK,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c44480002.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c44480002.dkfilter,tp,LOCATION_DECK,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
--atk1/2
function c44480002.val(e,c)
	return e:GetHandler():GetBaseAttack()/2
end
--2def1/2
function c44480002.val2(e,c)
	return e:GetHandler():GetBaseDefense()/2
end