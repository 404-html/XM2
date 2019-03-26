--幻灭神话 妖精收音录
function c84530782.initial_effect(c)
	c:EnableCounterPermit(0x831)
	c:SetCounterLimit(0x831,4)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c84530782.ctop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c84530782.destg)
	e3:SetValue(c84530782.value)
	e3:SetOperation(c84530782.desop)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x8351))
	e4:SetCondition(c84530782.atkcon)
	e4:SetValue(c84530782.atkval)
	c:RegisterEffect(e4)
	--to hand
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1,84530782)
	e5:SetCondition(c84530782.thcon)
	e5:SetTarget(c84530782.thtg)
	e5:SetOperation(c84530782.thop)
	c:RegisterEffect(e5)
	--togr
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e6:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_IGNORE_RANGE)
	e6:SetCode(EFFECT_SEND_REPLACE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c84530782.rcon)
	e6:SetTarget(c84530782.rtg)
	e6:SetValue(c84530782.rval)
	e6:SetOperation(c84530782.rop)  
	c:RegisterEffect(e6)
end
function c84530782.ctfilter(c)
	return c:IsFaceup() and (c:GetLevel()==1 or c:GetRank()==1 or c:GetLink()==1) and c:IsSetCard(0x8351) and c:IsRace(RACE_SPELLCASTER)
end
function c84530782.ctop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c84530782.ctfilter,1,nil) then
		e:GetHandler():AddCounter(0x831,1)
	end
end
function c84530782.dfilter(c)
	return c:IsLocation(LOCATION_MZONE) and (c:GetLevel()==1 or c:GetRank()==1 or c:GetLink()==1) and c:IsFaceup() and c:IsRace(RACE_SPELLCASTER) and c:IsSetCard(0x8351)
end
function c84530782.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c84530782.dfilter,1,nil,tp) and e:GetHandler():IsCanRemoveCounter(tp,0x831,1,REASON_EFFECT) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c84530782.value(e,c)
	return c:IsFaceup() and c:GetLocation()==LOCATION_MZONE and c:IsRace(RACE_SPELLCASTER)
end
function c84530782.desop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,0x831,1,REASON_EFFECT)
end
function c84530782.cfilter(c)
	return c:IsFaceup() and c:IsCode(84530797)
end
function c84530782.atkcon(e,c)
	return Duel.IsExistingMatchingCard(c84530782.cfilter,tp,LOCATION_FZONE,0,1,nil)
end
function c84530782.atkval(e,c)
	return e:GetHandler():GetCounter(0x831)*125
end
function c84530782.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x8351) and c:GetLevel()==1 and c:IsRace(RACE_SPELLCASTER) and c:IsAbleToHand()
end
function c84530782.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x831)>=3
end
function c84530782.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84530782.thfilter,tp,0x01+0x10,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,0x01+0x10)
end
function c84530782.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c84530782.thfilter,tp,0x01+0x10,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c84530782.rcon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return locL==OCATION_HAND and re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0x8351) and re:GetHandler():GetLevel()==1
end
function c84530782.defilter(c,tp)
	return c:GetDestination()==LOCATION_GRAVE and c:IsLocation(LOCATION_HAND) and c:IsSetCard(0x8351) and c:GetLevel()==1
end
function c84530782.rtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c84530782.defilter,1,nil,tp) and  e:GetHandler():GetCounter(0x831)>=1 end
	local g=eg:Filter(c84530782.defilter,nil,tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),220)
end
function c84530782.rop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,0x831,1,REASON_EFFECT)
	local g=e:GetLabelObject()
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	g:Clear()
end
function c84530782.rval(e,c)
	return c84530782.defilter(c,e:GetHandlerPlayer())
end
