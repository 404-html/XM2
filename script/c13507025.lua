local m=13507025
local tg={13507008,13507010,13507020,13507030}
local cm=_G["c"..m]
cm.name="圆环领主 波鲁哈"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Material
	aux.AddFusionProcCodeFun(c,tg[1],cm.mfilter,1,true,true)
	--Special Summon Condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(cm.splimit)
	c:RegisterEffect(e1)
	--Special Summon Rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(cm.sprcon)
	e2:SetOperation(cm.sprop)
	c:RegisterEffect(e2)
	--Move
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(cm.mvtg)
	e3:SetOperation(cm.mvop)
	c:RegisterEffect(e3)
end
function cm.isPirate(c)
	return c:GetCode()>tg[2] and c:GetCode()<=tg[3]
end
function cm.isLord(c)
	return c:GetCode()>tg[3] and c:GetCode()<=tg[4]
end
--Fusion Material
function cm.mfilter(c)
	return cm.isPirate(c)
end
--Special Summon Condition
function cm.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
--Special Summon Rule
function cm.matfilter(c)
	return c:IsFaceup() and (c:IsFusionCode(tg[1]) or cm.mfilter(c)) and c:IsAbleToGraveAsCost()
end
function cm.sprfilter1(c,g)
	return g:IsExists(cm.sprfilter2,1,c,c)
end
function cm.sprfilter2(c,mc)
	return ((c:IsFusionCode(tg[1]) and cm.mfilter(mc)) or (cm.mfilter(c) and mc:IsFusionCode(tg[1])))
end
function cm.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(cm.matfilter,tp,LOCATION_REMOVED,0,nil)
	return Duel.GetLocationCountFromEx(tp)>0
		and g:IsExists(cm.sprfilter1,1,nil,g)
end
function cm.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(cm.matfilter,tp,LOCATION_REMOVED,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g1=g:FilterSelect(tp,cm.sprfilter1,1,1,nil,g)
	local mc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=g:FilterSelect(tp,cm.sprfilter2,1,1,mc,mc)
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_COST+REASON_RETURN)
end
--Move
function cm.mvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_CONTROL)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(m,1))
	Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,0,1,1,nil)
end
function cm.mvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=math.log(s,2)
	Duel.MoveSequence(tc,nseq)
end