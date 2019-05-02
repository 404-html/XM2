--真红眼黑王龙
function c44470110.initial_effect(c)
    c:SetUniqueOnField(1,0,44470110)
	--fusion material
	aux.AddFusionProcFun2(c,c44470110.mfilter1,c44470110.mfilter2,true)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44470110,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,44470110)
	e1:SetCondition(c44470110.thcon)
	e1:SetTarget(c44470110.thtg)
	e1:SetOperation(c44470110.thop)
	c:RegisterEffect(e1)
	--immune
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_IMMUNE_EFFECT)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCondition(c44470110.imcon)
	e11:SetValue(c44470110.efilter)
	c:RegisterEffect(e11)
	--0
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e12:SetOperation(c44470110.atkop)
	c:RegisterEffect(e12)
end
c44470110.material_setcode=0x3b
function c44470110.mfilter1(c)
	return c:IsCode(74677422)
end
function c44470110.mfilter2(c)
	return c:GetAttack()>=2400
end
--search
function c44470110.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c44470110.thfilter(c)
	return (c:IsSetCard(0x3b) or c:IsCode(52684508))
	and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c44470110.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470110.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44470110.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44470110.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
--immune
function c44470110.imcon(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
end
function c44470110.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
--0
function c44470110.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if d==c then a,d=d,a end
	if a~=c or not d or d:IsControler(tp) or not d:IsRelateToBattle() then return end
		local da=d:GetTextAttack()
		local dd=d:GetTextDefense()
		if d:IsImmuneToEffect(e) then 
			da=d:GetBaseAttack()
			dd=d:GetBaseDefense() 
		end
		if da<0 then da=0 end
		if dd<0 then dd=0 end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		d:RegisterEffect(e1,true)
end