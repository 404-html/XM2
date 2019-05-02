local m=13502108
local tg={13502000,13502100}
local cm=_G["c"..m]
cm.name="使魔莉莉"
function cm.initial_effect(c)
	--Pendulum Summon
	aux.EnablePendulumAttribute(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(cm.sppcon)
	c:RegisterEffect(e1)
end
function cm.isset(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Special Summon
function cm.sppfilter(c)
	return c:IsFaceup() and cm.isset(c)
end
function cm.sppcon(e,c)
	if c==nil then return true end
	return Duel.GetMZoneCount(c:GetControler())>0 and
		Duel.IsExistingMatchingCard(cm.sppfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end