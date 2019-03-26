--绀碧色天空
function c44444014.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44444014,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44444014,1))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,44444014)
	e2:SetTarget(c44444014.destg)
	e2:SetValue(c44444014.value)
	e2:SetOperation(c44444014.desop)
	c:RegisterEffect(e2)
	--damage conversion
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(44444014,2))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_HAND+LOCATION_ONFIELD)
	e3:SetCountLimit(1,44444114)
	e3:SetCost(c44444014.thcost)
	e3:SetOperation(c44444014.operation)
	c:RegisterEffect(e3)
end
function c44444014.dfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsControler(tp) and not c:IsType(TYPE_EFFECT) 
end
function c44444014.repfilter(c)
	return (not c:IsType(TYPE_EFFECT) or c:IsType(TYPE_DUAL)) and c:IsAbleToGrave() and c:IsType(TYPE_MONSTER) 
end
function c44444014.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c44444014.dfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c44444014.repfilter,tp,LOCATION_DECK,0,1,nil) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c44444014.value(e,c)
	return c:IsControler(e:GetHandlerPlayer())
end
function c44444014.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44444014.repfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
--damage conversion
function c44444014.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function c44444014.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_REVERSE_DAMAGE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c44444014.valcon)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c44444014.valcon(e,re,r,rp,rc)
	if bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 then
		if Duel.GetFlagEffect(tp,44444014)==0 then
			Duel.RegisterFlagEffect(tp,44444014,RESET_PHASE+PHASE_END,0,1)
			return true
		end
	end
	return false
end