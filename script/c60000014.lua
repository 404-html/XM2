--皇家进化源 多路兽
function c60000014.initial_effect(c)
	 --ritual level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_RITUAL_LEVEL)
	e1:SetValue(c60000014.rlevel)
	c:RegisterEffect(e1)
	--destroy sub
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e3:SetValue(c60000014.repval)
	c:RegisterEffect(e3)
	--disable
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(60000014,2))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e5:SetCode(EVENT_CHAINING)
	e5:SetCountLimit(1)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c60000014.discon)
	e5:SetTarget(c60000014.distg)
	e5:SetOperation(c60000014.disop)
	c:RegisterEffect(e5)
end
function c60000014.rlevel(e,c)
	local lv=e:GetHandler():GetLevel()
	if (c:IsCode(60000001)or c:IsCode(60000002)) then
		local clv=c:GetLevel()
		return lv*65536+clv
	else return lv end
end
function c60000014.repval(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c60000014.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev)
end
function c60000014.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c60000014.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end