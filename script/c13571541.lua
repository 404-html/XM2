local m=13571541
local cm=_G["c"..m]
cm.name="歪秤 无谋吞噬"
function cm.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(cm.target)
	e1:SetOperation(cm.activate)
	c:RegisterEffect(e1)
	--Act In Hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(cm.handcon)
	c:RegisterEffect(e2)
end
--Activate
function cm.filter(c)
	return c:IsFaceup() and c:IsLocation(LOCATION_REMOVED) and c:IsType(TYPE_MONSTER)
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=math.floor(Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)/2)
	local g=Duel.GetDecktopGroup(tp,ct)
	if chk==0 then return g:IsExists(Card.IsAbleToRemove,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,ct,0,0)
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=math.floor(Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)/2)
	local g=Duel.GetDecktopGroup(tp,ct)
	if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)~=0 then
		local sg=Duel.GetOperatedGroup()
		local rec=sg:FilterCount(cm.filter,nil)*300
		Duel.Recover(tp,rec,REASON_EFFECT)
	end
end
--Act In Hand
function cm.handcon(e)
	return Duel.GetCurrentChain()>1
end