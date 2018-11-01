--少女前線 將軍I-39Z
local m=71956215
local set=0xde5
local cm=_G["c"..m]
function cm.initial_effect(c)
	--Xyz Summon
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(cm.xyzcon)
	e1:SetOperation(cm.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--Material
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCondition(cm.condition)
	e2:SetTarget(cm.target)
	e2:SetOperation(cm.operation)
	c:RegisterEffect(e2)
	--Atk Up
	local e3=Effect.CreateEffect(c)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(cm.atkval)
	c:RegisterEffect(e3)
	--destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(cm.reptg)
	c:RegisterEffect(e4)
end
--Xyz Summon
function cm.mfilter(c,xyzc)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0 and c:IsCanBeXyzMaterial(xyzc)
end
function cm.xyzfilter1(c,g)
	return g:IsExists(cm.xyzfilter2,1,c,c:GetRank())
end
function cm.xyzfilter2(c,rk)
	return c:GetRank()==rk
end
function cm.xyzcon(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=nil
	if og then
		mg=og:Filter(cm.mfilter,nil,c)
	else
		mg=Duel.GetMatchingGroup(cm.mfilter,tp,LOCATION_MZONE,0,nil,c)
	end
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and (not min or min<=2 and max>=2)
		and mg:IsExists(cm.xyzfilter1,1,nil,mg)
end
function cm.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	local g=nil
	local sg=Group.CreateGroup()
	if og and not min then
		g=og
		local tc=og:GetFirst()
		while tc do
			sg:Merge(tc:GetOverlayGroup())
			tc=og:GetNext()
		end
	else
		local mg=nil
		if og then
			mg=og:Filter(cm.mfilter,nil,c)
		else
			mg=Duel.GetMatchingGroup(cm.mfilter,tp,LOCATION_MZONE,0,nil,c)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		g=mg:FilterSelect(tp,cm.xyzfilter1,1,1,nil,mg)
		local tc1=g:GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g2=mg:FilterSelect(tp,cm.xyzfilter2,1,1,tc1,tc1:GetRank())
		local tc2=g2:GetFirst()
		g:Merge(g2)
		sg:Merge(tc1:GetOverlayGroup())
		sg:Merge(tc2:GetOverlayGroup())
	end
	Duel.SendtoGrave(sg,REASON_RULE)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
--Material
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function cm.filter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:GetControler()==tp or c:IsAbleToChangeControler()
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,tp) end
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup()
	  and Duel.IsExistingMatchingCard(cm.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,tp) then
		local g=Duel.GetMatchingGroup(cm.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
		Duel.Overlay(c,g)
	end
end
--Atk Up
function cm.atkval(e,c)
	return c:GetOverlayCount()*450
end
function cm.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(m,3)) then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end