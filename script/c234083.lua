--死寂之永恒白洞龙·改
function c234083.initial_effect(c)
    --xyz summon
	aux.AddXyzProcedure(c,nil,12,5)
	c:EnableReviveLimit()
	--xyz
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetDescription(aux.Stringid(234083,0))
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1,234083+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c234083.xyzcon)
	e1:SetOperation(c234083.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e2)
	--summon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c234083.sumsuc)
	c:RegisterEffect(e3)
	--negate
	local e51=Effect.CreateEffect(c)
	e51:SetDescription(aux.Stringid(234083,0))
	e51:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e51:SetType(EFFECT_TYPE_IGNITION)
	e51:SetRange(LOCATION_MZONE)
	e51:SetCountLimit(1)
	e51:SetCost(c234083.negcost)
	e51:SetTarget(c234083.negtg)
	e51:SetOperation(c234083.negop)
	c:RegisterEffect(e51)
	--immune
	local e54=Effect.CreateEffect(c)
	e54:SetType(EFFECT_TYPE_SINGLE)
	e54:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e54:SetRange(LOCATION_MZONE)
	e54:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e54:SetCondition(c234083.tgcon)
	e54:SetValue(c234083.tgvalue)
	c:RegisterEffect(e54)
	--No death
	local e55=Effect.CreateEffect(c)
	e55:SetDescription(aux.Stringid(234083,1))
	e55:SetCode(EFFECT_SEND_REPLACE)
	e55:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e55:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e55:SetRange(LOCATION_MZONE)
	e55:SetCondition(c234083.atcon)
	e55:SetTarget(c234083.crystaltg)
	c:RegisterEffect(e55)
	--indes
	local e61=Effect.CreateEffect(c)
	e61:SetType(EFFECT_TYPE_SINGLE)
	e61:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e61:SetRange(LOCATION_MZONE)
	e61:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e61:SetValue(1)
	c:RegisterEffect(e61)
	--cannot release
	local e64=Effect.CreateEffect(c)
	e64:SetType(EFFECT_TYPE_SINGLE)
	e64:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e64:SetRange(LOCATION_MZONE)
	e64:SetCode(EFFECT_UNRELEASABLE_SUM)
	e64:SetValue(1)
	c:RegisterEffect(e64)
	local e65=e64:Clone()
	e65:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e65)
	--cannot be fusion material
	local e66=e64:Clone()
	e66:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	c:RegisterEffect(e66)
	--CANNOT TO DECK
	local e71=Effect.CreateEffect(c)
	e71:SetType(EFFECT_TYPE_SINGLE)
	e71:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e71:SetRange(LOCATION_MZONE)
	e71:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e71)
end
--xyz summon
function c234083.xyzfilter(c)
	return bit.band(c:GetOriginalType(),0x4)~=0
end
function c234083.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 
	and Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())<=0 then return false end
	return Duel.GetLocationCountFromEx(tp)>0 and Duel.IsExistingMatchingCard(c234083.xyzfilter,tp,LOCATION_MZONE,0,5,nil) 
end
function c234083.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c234083.xyzfilter,tp,LOCATION_MZONE,0,5,5,nil)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end
--summon success
function c234083.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c234083.chlimit(tp))
end
function c234083.chlimit(p)
   return function (re,rp,tp)
	     return  p==tp 
    end
end	
--No death
function c234083.tgcon(e)
	return e:GetHandler():GetOverlayCount()~=0
end
function c234083.tgvalue(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c234083.atcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()>=1 and bit.band(r,REASON_BATTLE)==0
end
function c234083.crystaltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	return true
end
--negate
function c234083.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c234083.filter(c)
	return c:IsFaceup() and not c:IsDisabled()
end
function c234083.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c234083.filter,tp,0xc,0xc,1,e:GetHandler()) end
end
function c234083.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c234083.filter,tp,0xc,0xc,c)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		if tc:GetAttack()>0 then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_ATTACK_FINAL)
		e3:SetValue(0)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_SET_DEFENSE_FINAL)
		tc:RegisterEffect(e4)
		tc:RegisterFlagEffect(234083,RESET_EVENT+0x17a0000,0,1)
		end
		tc=g:GetNext()
	end
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(234083,2))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c234083.damcon)
	e1:SetTarget(c234083.damtg)
	e1:SetOperation(c234083.damop)
	Duel.RegisterEffect(e1,tp)
end
function c234083.dfilter(c)
	return c:GetFlagEffect(234083)~=0
end
function c234083.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c234083.dfilter,1,nil)
end
function c234083.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    local tc=eg:GetFirst()
	if chk==0 then return tc:GetFlagEffect(234083)~=0 end
	local dam=tc:GetTextAttack()+tc:GetTextDefense()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c234083.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,0X40)
	 if Duel.GetMatchingGroupCount(c234083.dfilter,tp,0xc,0xc,nil)<=0 then
	 e:Reset() 
	 end
end