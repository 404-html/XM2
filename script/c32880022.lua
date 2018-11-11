--HS 硬币
function c32880022.initial_effect(c)
	c:EnableCounterPermit(0x755)
	c:SetCounterLimit(0x755,10)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,32880022+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c32880022.operation)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32880022,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCondition(c32880022.ctcon)
	e2:SetOperation(c32880022.ctop)
	c:RegisterEffect(e2)
	-- counter
	local e3=Effect.CreateEffect(c) 
	e3:SetDescription(aux.Stringid(32880022,1))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c32880022.rctcon)
	e3:SetOperation(c32880022.recop)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e5)
end
function c32880022.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local at=Duel.GetTurnCount()
	if at<=10 then
	   c:AddCounter(0x755,at)
	elseif ct>10 then 
		   c:AddCounter(0x755,10)
	end
	Duel.SetChainLimit(aux.FALSE)
end
function c32880022.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c32880022.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetTurnCount()
	if ct<=10 then
	   c:AddCounter(0x755,ct)
	elseif ct>10 then 
		   c:AddCounter(0x755,10)
	end
end
function c32880022.rctcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c32880022.recop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local st=c:GetCounter(0x755)
	if c then
	c:RemoveCounter(tp,0x755,st,REASON_EFFECT)
	end
end