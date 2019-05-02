local m=13502107
local tg={13502100,13502200}
local cm=_G["c"..m]
cm.name="混沌化 使魔莉莉"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon
	aux.AddXyzProcedure(c,cm.mfilter,5,2,cm.ovfilter,aux.Stringid(m,0))
	--Remove
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(cm.rmcon)
	e1:SetOperation(cm.rmop)
	c:RegisterEffect(e1)
end
function cm.isset(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Xyz Summon
function cm.mfilter(c)
	return c:IsRace(RACE_FIEND)
end
function cm.ovfilter(c)
	return c:IsFaceup() and c:IsLevel(5) and cm.isset(c)
end
--Remove
function cm.rmcon(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetAttackTarget()
	if tc==e:GetHandler() then tc=Duel.GetAttacker() end
	return tc and tc:IsControler(1-tp)
end
function cm.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	if tc==e:GetHandler() then tc=Duel.GetAttacker() end
	if tc and tc:IsRelateToBattle() then
		Duel.Hint(HINT_CARD,0,m)
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end