--少女前線 MK-E86式
local m=71956209
local set=0xde5
local cm=_G["c"..m]
function cm.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,m)
	e1:SetCondition(cm.spcon)
	e1:SetOperation(cm.spop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(cm.target1)
	e2:SetOperation(cm.operation1)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetDescription(aux.Stringid(m,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(TIMING_DAMAGE_STEP)
	e3:SetRange(LOCATION_HAND)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCondition(cm.condition2)
	e3:SetCost(cm.cost2)
	e3:SetOperation(cm.operation2)
	c:RegisterEffect(e3)
end
function cm.spfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xde5) and not c:IsCode(m) and c:IsAbleToHandAsCost()
end
function cm.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(cm.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,cm.spfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_COST)
end
function cm.filter(c,sp)
	return c:GetSummonPlayer()==sp
end
function cm.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function cm.operation1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
function cm.condition2(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d~=nil and d:IsFaceup() and ((a:GetControler()==tp and a:IsAttribute(ATTRIBUTE_EARTH ) and a:IsRelateToBattle())
		or (d:GetControler()==tp and d:IsAttribute(ATTRIBUTE_EARTH ) and d:IsRelateToBattle()))
end
function cm.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function cm.operation2(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsRelateToBattle() or not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetOwnerPlayer(tp)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	if a:GetControler()==tp then
		e1:SetValue(d:GetAttack())
		a:RegisterEffect(e1)
	else
		e1:SetValue(a:GetAttack())
		d:RegisterEffect(e1)
	end
end
