--百夜·星之沉落
function c44449044.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44449044+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c44449044.cost)
	e1:SetTarget(c44449044.target)
	e1:SetOperation(c44449044.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c44449044.handcon)
	c:RegisterEffect(e2)
	--act in hand2
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_SINGLE)
	e22:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e22:SetCondition(c44449044.handcon2)
	c:RegisterEffect(e22)

end
function c44449044.sfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c44449044.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c44449044.sfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44449044.sfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	if chk==0 then return g:IsAbleToRemoveAsCost() end
	local tc=g:GetFirst()
	if Duel.Remove(tc,tc:GetPosition(),REASON_COST+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetLabelObject(tc)
		e1:SetCountLimit(1)
		e1:SetOperation(c44449044.retop)
		Duel.RegisterEffect(e1,tp)
	end
	local tpc=tc:GetControler()
	e:SetLabel(tpc)
end
function c44449044.target(e,tp,eg,ep,ev,re,r,rp,chk)
    local tpcc=e:GetLabel()
	if chk==0 then return Duel.IsPlayerCanDraw(tpcc,1) end
	Duel.SetTargetPlayer(tpcc)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tpcc,1)
end
function c44449044.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c44449044.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
--act in hand
function c44449044.handcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_ONFIELD,0)==0 
end
--act in hand2
function c44449044.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL)
end
function c44449044.handcon2(e)
	return Duel.IsExistingMatchingCard(c44449044.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end