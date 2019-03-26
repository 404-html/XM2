--太刀鸣狐-樱
function c44444203.initial_effect(c)
   aux.EnableDualAttribute(c)
   	--attack up and draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(44444203,1))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c44444203.target)
	e1:SetOperation(c44444203.operation)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44444203,2))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetCountLimit(1,44444203)
	e2:SetTarget(c44444203.tg)
	e2:SetOperation(c44444203.op)
	c:RegisterEffect(e2)
	--Level
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetCode(EFFECT_CHANGE_LEVEL)
	e12:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e12:SetValue(7)
	c:RegisterEffect(e12)
end
function c44444203.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x642)
end
function c44444203.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44444203.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44444203.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44444203.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c44444203.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		tc:RegisterFlagEffect(44444203,RESET_EVENT+0x1220000+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(44444203,0))
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLE_DESTROYING)
		e1:SetLabelObject(tc)
		e1:SetCondition(c44444203.rmcon1)
		e1:SetOperation(c44444203.rmop1)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local e11=Effect.CreateEffect(c)
		e11:SetType(EFFECT_TYPE_SINGLE)
		e11:SetCode(EFFECT_UPDATE_ATTACK)
		e11:SetReset(RESET_EVENT+0x1fe0000)
		e11:SetValue(500)
		tc:RegisterEffect(e11)
	end
	Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
end
function c44444203.drfilter(c)
	return c:IsType(TYPE_MONSTER) or c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)
end
function c44444203.rmcon1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return eg:IsContains(tc) and tc:GetFlagEffect(44444203)~=0
end
function c44444203.rmop1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c44444203.drfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()<1 then return end
    Duel.Draw(tp,1,REASON_EFFECT)
end
--search
function c44444203.thfilter(c)
	return c:IsSetCard(0x642) and c:IsAbleToHand() and c:IsType(TYPE_MONSTER) and not c:IsCode(44444203)
end
function c44444203.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44444203.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44444203.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44444203.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end