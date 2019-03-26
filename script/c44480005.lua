--瞳器使·艾茜
function c44480005.initial_effect(c)
	c:SetUniqueOnField(1,0,44480005)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480005,0))
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c44480005.target)
	e1:SetOperation(c44480005.operation)
	c:RegisterEffect(e1)
	--atk1/2
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetCode(EFFECT_SET_BASE_ATTACK)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(1100)
	c:RegisterEffect(e11)
	--2def1/2
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetCode(EFFECT_SET_BASE_DEFENSE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetValue(1500)
	c:RegisterEffect(e12)
end
--summon
function c44480005.sfilter(c)
	return c:IsSetCard(0x646) and c:IsSummonable(true,e)
end
function c44480005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480005.sfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c44480005.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c44480005.sfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
     	Duel.Summon(tp,tc,true,nil)
	end
end
--atk1/2
function c44480005.val(e,c)
	return e:GetHandler():GetBaseAttack()/2
end
--2def1/2
function c44480005.val2(e,c)
	return e:GetHandler():GetBaseDefense()/2
end
