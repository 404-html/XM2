--红瞳器·暴怒畸形锤
function c44480072.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480072,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,44480072+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c44480072.target)
	e1:SetOperation(c44480072.activate)
	c:RegisterEffect(e1)
	--atk
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_EQUIP)
	e12:SetCode(EFFECT_UPDATE_ATTACK)
	e12:SetValue(1000)
	c:RegisterEffect(e12)
	--disable
	local e44=Effect.CreateEffect(c)
	e44:SetType(EFFECT_TYPE_EQUIP)
	e44:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e44)
	local e45=Effect.CreateEffect(c)
	e45:SetType(EFFECT_TYPE_EQUIP)
	e45:SetCode(EFFECT_DISABLE_EFFECT)
	c:RegisterEffect(e45)
	--destroy
	local e46=Effect.CreateEffect(c)
	e46:SetType(EFFECT_TYPE_EQUIP)
	e46:SetCode(EFFECT_SELF_DESTROY)
	e46:SetCondition(c44480072.descon)
	c:RegisterEffect(e46)
end
function c44480072.dfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and c:IsType(TYPE_MONSTER)
end
function c44480072.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480072.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c44480072.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c44480072.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c44480072.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end

function c44480072.descon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():GetEquipTarget():IsSetCard(0x645)
end