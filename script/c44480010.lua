--蓝瞳器使·艾尔丝
function c44480010.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsCode,44480001),aux.FilterBoolFunction(c44480010.fusfilter),true)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480010,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	--e1:SetCountLimit(1,44480010)
	e1:SetCondition(c44480010.sprcon)
	e1:SetOperation(c44480010.sprop)
	c:RegisterEffect(e1)
	--ex spsummon
	local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(44480010,1))
	e22:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e22:SetType(EFFECT_TYPE_QUICK_O)
	e22:SetCode(EVENT_CHAINING)
	e22:SetRange(LOCATION_MZONE)
	e22:SetCountLimit(1,44480010)
	e22:SetCondition(c44480010.spcon)
	e22:SetTarget(c44480010.sptg)
	e22:SetOperation(c44480010.spop)
	c:RegisterEffect(e22)
	--search
	local e21=Effect.CreateEffect(c)
	e21:SetDescription(aux.Stringid(44480010,2))
	e21:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e21:SetType(EFFECT_TYPE_IGNITION)
	e21:SetRange(LOCATION_ONFIELD)
	e21:SetCountLimit(1,44481010)
	e21:SetTarget(c44480010.target)
	e21:SetOperation(c44480010.operation)
	c:RegisterEffect(e21)
end
function c44480010.eqfilter(c)
	return c:IsSetCard(0x646) 
end
function c44480010.fusfilter(c)
	return c:GetEquipGroup():IsExists(c44480010.eqfilter,1,nil)
end
--special summon rule
function c44480010.sprfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsFaceup() and c:IsReleasable() and c:IsCode(44480001)
end
function c44480010.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCountFromEx(tp)>0
		and Duel.IsExistingMatchingCard(c44480010.sprfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c44480010.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	if Duel.GetLocationCountFromEx(tp,tp,c)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c44480010.sprfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
--ex spsummon
function c44480010.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev)
end
function c44480010.spfilter(c,e,tp)
	return c:IsCode(44480011) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44480010.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())>0
		and e:GetHandler():IsAbleToExtra()
		and Duel.IsExistingMatchingCard(c44480010.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c44480010.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCountFromEx(tp,tp,c)<=0 then return end
	if c:IsRelateToEffect(e) and c:IsFaceup() and Duel.SendtoDeck(c,nil,2,REASON_EFFECT)~=0 then
		local tc=Duel.GetFirstMatchingCard(c44480010.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
		if tc then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
--search
function c44480010.thfilter(c)
	return c:IsAbleToHand() and (c:IsCode(44480020) or c:IsSetCard(0x647))  
end
function c44480010.target(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c44480010.thfilter,tp,LOCATION_DECK,0,1,nil) 
	and not c:IsHasEffect(EFFECT_REVERSE_UPDATE) and c:GetAttack()>=1000 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44480010.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		if c:IsRelateToEffect(e) and c:IsFaceup() and c:GetAttack()>=1000 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-1000)
		c:RegisterEffect(e1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44480010.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	    local tc=g:GetFirst()
        Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end