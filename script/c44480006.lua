--瞳器使·艾拉
function c44480006.initial_effect(c)
    c:SetUniqueOnField(1,0,44480006)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480006,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c44480006.target)
	e1:SetOperation(c44480006.operation)
	c:RegisterEffect(e1)
	--atk1/2
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetCode(EFFECT_SET_BASE_ATTACK)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(1250)
	c:RegisterEffect(e11)
	--2def1/2
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetCode(EFFECT_SET_BASE_DEFENSE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetValue(1250)
	c:RegisterEffect(e12)
end
--to hand
function c44480006.filter(c)
	return c:IsSetCard(0x646) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and not c:IsCode(44480006)
end
function c44480006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480006.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44480006.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44480006.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
--atk1/2
function c44480006.val(e,c)
	return e:GetHandler():GetBaseAttack()/2
end
--2def1/2
function c44480006.val2(e,c)
	return e:GetHandler():GetBaseDefense()/2
end
