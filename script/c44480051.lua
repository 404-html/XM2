--瞳器·深邃之蓝
function c44480051.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480051,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44480051+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_EQUIP)
	--e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c44480051.target)
	e1:SetOperation(c44480051.activate)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(600)
	c:RegisterEffect(e2)
	--disable
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_EQUIP)
	e21:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e21)
	--IMMUNE
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_EQUIP)
	e22:SetCode(EFFECT_IMMUNE_EFFECT)
	e22:SetCondition(c44480051.descon)
	e22:SetValue(c44480051.efilter)
	c:RegisterEffect(e22)
end
function c44480051.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget():IsCode(44480002,44480009) 
end
function c44480051.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
	and te:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
--Destroy 
function c44480051.defilter(c)
	return c:IsDestructable()
end
function c44480051.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480051.defilter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c44480051.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c44480051.defilter,tp,0,LOCATION_SZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end