--蓝瞳器使·艾尔
function c44480009.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c44480009.matfilter,1,1)
	--atk1/2
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1200)
	c:RegisterEffect(e1)
	--sset
	local e21=Effect.CreateEffect(c)
	e21:SetDescription(aux.Stringid(44480009,1))
	--e21:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e21:SetType(EFFECT_TYPE_IGNITION)
	e21:SetRange(LOCATION_MZONE)
	e21:SetCountLimit(1,44480009)
	e21:SetTarget(c44480009.target)
	e21:SetOperation(c44480009.operation)
	c:RegisterEffect(e21)
end
function c44480009.matfilter(c)
	return c:IsLinkSetCard(0x646)
	--and bit.band(c:GetSummonType(),SUMMON_TYPE_NORMAL)==SUMMON_TYPE_NORMAL
end
--atk1/2
function c44480009.val(e,c)
	return e:GetHandler():GetBaseAttack()/2
end
--sset
function c44480009.filter(c)
	return c:IsCode(44480100) and c:IsSSetable()
end
function c44480009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c44480009.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c44480009.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:GetAttack()>=1000 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-1000)
		c:RegisterEffect(e1)
	    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	    local g=Duel.SelectMatchingCard(tp,c44480009.filter,tp,LOCATION_DECK,0,1,1,nil)
	    if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
		Duel.ConfirmCards(1-tp,g)
		end
	end
end
