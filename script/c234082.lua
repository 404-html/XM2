--破灭之永恒末日龙·改
function c234082.initial_effect(c)
    --xyz summon
	aux.AddXyzProcedure(c,nil,12,5)
	c:EnableReviveLimit()
	--xyz
	--local e1=Effect.CreateEffect(c)
	--e1:SetType(EFFECT_TYPE_FIELD)
	--e1:SetCode(EFFECT_SPSUMMON_PROC)
	--e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	--e1:SetDescription(aux.Stringid(234082,0))
	--e1:SetRange(LOCATION_EXTRA)
	--e1:SetCountLimit(1,234082+EFFECT_COUNT_CODE_DUEL)
	--e1:SetCondition(c234082.xyzcon)
	--e1:SetOperation(c234082.xyzop)
	--e1:SetValue(SUMMON_TYPE_XYZ)
	--c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e2)
	--summon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c234082.sumsuc)
	c:RegisterEffect(e3)
	--to grave
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(234082,1))
	e5:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetCountLimit(1)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c234082.sgcost)
	e5:SetTarget(c234082.sgtg)
	e5:SetOperation(c234082.sgop)
	c:RegisterEffect(e5)
end
--xyz
function c234082.xyzfilter(c)
	return c:IsLevelAbove(5)
end
function c234082.rfilter(c,lv)
	return c:GetLevel()==lv
end
function c234082.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,0x4)<=0 
	and Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())<=0 then return false end
	return Duel.GetLocationCountFromEx(tp)>0 and Duel.IsExistingMatchingCard(c234082.xyzfilter,tp,LOCATION_REMOVED,0,5,nil) 
end
function c234082.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	--local g=Duel.SelectMatchingCard(tp,c234082.xyzfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local g=Duel.GetMatchingGroup(c234082.xyzfilter,tp,LOCATION_REMOVED,0,nil,e,tp)
	local g1=g:Select(tp,1,1,nil)
	g:Remove(c234082.rfilter,nil,g1:GetFirst():GetLevel())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g2=g:Select(tp,1,1,nil)
	g:Remove(c234082.rfilter,nil,g2:GetFirst():GetLevel())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g3=g:Select(tp,1,1,nil)
	g:Remove(c234082.rfilter,nil,g3:GetFirst():GetLevel())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g4=g:Select(tp,1,1,nil)
	g:Remove(c234082.rfilter,nil,g4:GetFirst():GetLevel())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g5=g:Select(tp,1,1,nil)
	g1:Merge(g2)
	g1:Merge(g3)
	g1:Merge(g4)
	g1:Merge(g5)
	c:SetMaterial(g1)
	Duel.Overlay(c,g1)
end
function c234082.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c234082.chlimit(tp))
end
function c234082.chlimit(p)
   return function (re,rp,tp)
	     return  p==tp 
    end
end
function c234082.sgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,5,0x80) end
	e:GetHandler():RemoveOverlayCard(tp,5,5,0x80)
end
function c234082.sgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0x2,0x2,1,nil)  end
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0x2,0x2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,g:GetCount()*300)
end
function c234082.sgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0x2,0x2,nil)
	if g:GetCount()>0 then
	Duel.SendtoGrave(g,0x80)
	local og=Duel.GetOperatedGroup()
	local ct=og:FilterCount(Card.IsLocation,nil,0x10)
	Duel.BreakEffect()
	Duel.Damage(1-tp,ct*300,0x80)
	end
end