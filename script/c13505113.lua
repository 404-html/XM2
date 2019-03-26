local m=13505113
local cm=_G["c"..m]
cm.name="魔导巧壳 露恩"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	--XYZ Summon
	aux.AddXyzProcedureLevelFree(c,cm.mfilter,aux.TRUE,2,2)
	--Move
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(cm.mvcost)
	e1:SetCondition(cm.mvcon)
	e1:SetOperation(cm.mvop)
	e1:SetHintTiming(TIMING_END_PHASE,TIMING_END_PHASE)
	c:RegisterEffect(e1)
end
--XYZ Summon
function cm.mfilter(c,xyzc)
	return c:IsLevelAbove(1) and c:IsXyzType(TYPE_NORMAL)
		and (c:IsXyzLevel(xyzc,5) or (c:IsLocation(LOCATION_MZONE) and c:IsType(TYPE_PENDULUM)))
end
--Move
function cm.tdfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsAbleToDeck()
end
function cm.mvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function cm.mvcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_CONTROL)>0
end
function cm.mvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsControler(1-tp) or Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=math.log(s,2)
	Duel.MoveSequence(c,nseq)
	--To Deck
	if Duel.IsExistingMatchingCard(cm.tdfilter,tp,LOCATION_REMOVED,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(m,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,cm.tdfilter,tp,LOCATION_REMOVED,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.ConfirmCards(1-tp,g)
			Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
		end
	end
end