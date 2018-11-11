--HS英雄 猎人
function c32880018.initial_effect(c)
	c:SetUniqueOnField(1,0,aux.FilterBoolFunction(Card.IsCode,32880018),LOCATION_MZONE)
	--special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCondition(c32880018.hspcon)
	e1:SetOperation(c32880018.hspop)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c32880018.cost)
	e2:SetTarget(c32880018.damtg)
	e2:SetOperation(c32880018.damop)
	c:RegisterEffect(e2)
end
function c32880018.repfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) 
end
function c32880018.hspcon(e,c)
	local g=Duel.GetMatchingGroup(c32880018.repfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local ct=g:GetCount()*200
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.CheckLPCost(tp,ct)
end
function c32880018.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c32880018.repfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local ct=g:GetCount()*200
	Duel.PayLPCost(tp,ct)
end
function c32880018.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,2,REASON_COST)
end
function c32880018.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c32880018.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
