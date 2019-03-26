local m=13507018
local tg={13507020,13507030}
local cm=_G["c"..m]
cm.name="圆环海盗 阿穆朵希雅斯"
function cm.initial_effect(c)
	--Special Summon Proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(cm.sppcon)
	c:RegisterEffect(e1)
	--Pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function cm.isLord(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Special Summon Proc
function cm.sppfilter(c)
	return c:IsFaceup() and cm.isLord(c)
end
function cm.sppcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingMatchingCard(cm.sppfilter,tp,LOCATION_MZONE,0,1,nil) 
end