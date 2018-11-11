local m=13571534
local cm=_G["c"..m]
cm.name="歪秤 分叉赤虫"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Link
	aux.AddLinkProcedure(c,cm.mfilter,1,1)
	--Summon Limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_COST)
	e1:SetCost(cm.spcost)
	c:RegisterEffect(e1)
	--Attack Limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ATTACK_COST)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCost(cm.atcost)
	e2:SetOperation(cm.atop)
	c:RegisterEffect(e2)
	--Draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetCondition(cm.condition)
	e3:SetOperation(cm.operation)
	c:RegisterEffect(e3)
end
--Link
function cm.mfilter(c)
	return c:IsSummonType(SUMMON_TYPE_NORMAL)
end
--Summon Limit
function cm.spfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
function cm.spcost(e,c,tp,st)
	if bit.band(st,SUMMON_TYPE_LINK)~=SUMMON_TYPE_LINK then return true end
	return not Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_MZONE,0,1,nil)
end
--Attack Limit
function cm.atcost(e,c,tp)
	return Duel.GetFlagEffect(tp,m)==0
end
function cm.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(tp,m,0,0,1)
end
--Draw
function cm.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.GetAttackTarget()~=nil
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	Duel.Draw(tp,1,REASON_EFFECT)
end