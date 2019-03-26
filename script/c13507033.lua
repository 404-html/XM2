local m=13507033
local tg={13507021}
local cm=_G["c"..m]
cm.name="堕落海盗 阿里茨"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Xyz Summon
	aux.AddXyzProcedure(c,nil,6,2,cm.ovfilter,aux.Stringid(m,0))
	--Atk Down
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(cm.atkval)
	c:RegisterEffect(e1)
end
--Xyz Summon
function cm.ovfilter(c)
	return c:IsFaceup() and c:IsCode(tg[1])
end
--Atk Down
function cm.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function cm.atkval(e,c)
	if c:IsFacedown() then return 0 end
	return -100*Duel.GetMatchingGroupCount(cm.atkfilter,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)
end