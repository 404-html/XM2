--少女前線 GK8-23式
local m=71956201
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
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(cm.retcon)
	e2:SetTarget(cm.rettg)
	e2:SetOperation(cm.retop)
	c:RegisterEffect(e2)
	--cannot be battle target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(cm.atktg)
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
function cm.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetReasonPlayer()~=tp
		and e:GetHandler():GetPreviousControler()==tp
end
function cm.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function cm.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_EFFECT)
	end
end
function cm.atktg(e,c)
	return c:IsFaceup() and c:GetCode()~=m and c:IsSetCard(0xde5)
end

