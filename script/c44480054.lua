--蓝瞳器·收割之镰
function c44480054.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetDescription(aux.Stringid(44480054,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44480054+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c44480054.target)
	e1:SetOperation(c44480054.activate)
	c:RegisterEffect(e1)
	--attack all
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_EQUIP)
	e12:SetCode(EFFECT_ATTACK_ALL)
	e12:SetValue(1)
	c:RegisterEffect(e12)
	--disable
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_EQUIP)
	e21:SetCode(EFFECT_DISABLE)
	--e21:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e21)
		--atkup
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_EQUIP)
	e22:SetCode(EFFECT_UPDATE_ATTACK)
	e22:SetValue(100)
	c:RegisterEffect(e22)
end
function c44480054.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x646)
end
function c44480054.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44480054.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44480054.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44480054.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c44480054.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		tc:RegisterFlagEffect(44480054,RESET_EVENT+0x1220000+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(44480054,0))
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLE_DESTROYING)
		e1:SetLabelObject(tc)
		e1:SetCondition(c44480054.rmcon1)
		e1:SetOperation(c44480054.rmop1)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local e11=Effect.CreateEffect(c)
		e11:SetType(EFFECT_TYPE_SINGLE)
		e11:SetCode(EFFECT_UPDATE_ATTACK)
		e11:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e11:SetValue(100)
		tc:RegisterEffect(e11)
		--disable
		local e21=Effect.CreateEffect(c)
		e21:SetType(EFFECT_TYPE_SINGLE)
		e21:SetCode(EFFECT_DISABLE)
		e21:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e21)
		local e31=Effect.CreateEffect(c)
		e31:SetType(EFFECT_TYPE_SINGLE)
		e31:SetCode(EFFECT_DISABLE_EFFECT)
		e31:SetValue(RESET_TURN_SET)
		e31:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e31)
	end
end
function c44480054.drfilter(c)
	return c:IsType(TYPE_MONSTER) or c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)
end
function c44480054.rmcon1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return eg:IsContains(tc) and tc:GetFlagEffect(44480054)~=0
end
function c44480054.rmop1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c44480054.drfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()<1 then return end
    Duel.Draw(tp,1,REASON_EFFECT)
end

