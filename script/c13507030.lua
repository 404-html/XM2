local m=13507030
local tg={13507020,13507030}
local cm=_G["c"..m]
cm.name="珊海王 高特里奥"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link Summon
	aux.AddLinkProcedure(c,cm.mfilter,6,6)
	--Lp 100
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(cm.lpcon)
	e1:SetOperation(cm.lpop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(cm.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function cm.isLord(c)
	return c:GetCode()>tg[1] and c:GetCode()<=tg[2]
end
--Link Summon
function cm.mfilter(c)
	return cm.isLord(c)
end
--Lp 100
function cm.lpcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK) and e:GetLabel()==1
end
function cm.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	Duel.SetLP(1-tp,100)
end
function cm.valfilter(c,g)
	return g:IsExists(Card.IsLinkAttribute,1,c,c:GetLinkAttribute())
end
function cm.valcheck(e,c)
	local g=c:GetMaterial()
	if g:GetCount()>0 and not g:IsExists(cm.valfilter,1,nil,g) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end