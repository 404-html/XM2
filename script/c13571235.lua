local m=13571235
local waipei={13570000,13580000}
local cm=_G["c"..m]
cm.name="歪秤 驱邪的光霞"
function cm.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(cm.cost)
	e2:SetTarget(cm.target)
	e2:SetOperation(cm.operation)
	c:RegisterEffect(e2)
	--Draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(m,1))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_RELEASE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCountLimit(1,m)
	e3:SetTarget(cm.drtg)
	e3:SetOperation(cm.drop)
	c:RegisterEffect(e3)
end
function cm.isWaiPei(c)
	return c:GetCode()>waipei[1] and c:GetCode()<waipei[2]
end
--Remove
function cm.costfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL) and c:IsReleasable()
end
function cm.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.costfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,cm.costfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
--Draw
function cm.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function cm.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	Duel.Draw(tp,1,REASON_EFFECT)
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		if not cm.isWaiPei(tc) then
			Duel.BreakEffect()
			Duel.SendtoDeck(tc,nil,1,REASON_EFFECT)
		end
		Duel.ShuffleHand(tp)
	end
end