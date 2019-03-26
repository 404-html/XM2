--红瞳器·惊惧太刀
function c44480071.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,44480071+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c44480071.con)
	e1:SetOperation(c44480071.activate)
	c:RegisterEffect(e1)
	--atk
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_EQUIP)
	e11:SetCode(EFFECT_UPDATE_ATTACK)
	e11:SetValue(900)
	c:RegisterEffect(e11)
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_EQUIP)
	e12:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
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
end
function c44480071.con(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return tp~=Duel.GetTurnPlayer() and bit.band(ph,PHASE_MAIN2+PHASE_END)==0
end
function c44480071.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(0,1)
	Duel.RegisterEffect(e1,tp)
end
