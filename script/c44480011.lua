--红瞳器使·艾尔丝
function c44480011.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsCode,44480001),aux.FilterBoolFunction(c44480011.fusfilter),true)

	--ex spsummon
	local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(44480011,1))
	e22:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e22:SetType(EFFECT_TYPE_QUICK_O)
	e22:SetCode(EVENT_CHAINING)
	e22:SetRange(LOCATION_MZONE)
	e22:SetCountLimit(1,44480011)
	e22:SetCondition(c44480011.spcon)
	e22:SetTarget(c44480011.sptg)
	e22:SetOperation(c44480011.spop)
	c:RegisterEffect(e22)
	--sset
	local e51=Effect.CreateEffect(c)
	e51:SetCategory(CATEGORY_EQUIP)
	e51:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e51:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e51:SetCode(EVENT_SPSUMMON_SUCCESS)
	e51:SetCountLimit(1,44480111)
	e51:SetTarget(c44480011.stg)
	e51:SetOperation(c44480011.sop)
	c:RegisterEffect(e51)
end
function c44480011.eqfilter(c)
	return c:IsSetCard(0x646) 
end
function c44480011.fusfilter(c)
	return c:GetEquipGroup():IsExists(c44480011.eqfilter,1,nil)
end

--ex spsummon
function c44480011.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev)
end
function c44480011.spfilter(c,e,tp)
	return c:IsCode(44480010) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c44480011.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())>0
		and e:GetHandler():IsAbleToExtra()
		and Duel.IsExistingMatchingCard(c44480011.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c44480011.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCountFromEx(tp,tp,c)<=0 then return end
	if c:IsRelateToEffect(e) and c:IsFaceup() and Duel.SendtoDeck(c,nil,2,REASON_EFFECT)~=0 then
		local tc=Duel.GetFirstMatchingCard(c44480011.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
		if tc then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
--sset
function c44480011.setfilter(c)
	return c:IsCode(44480020) and not c:IsForbidden()
end
function c44480011.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480011.setfilter,tp,LOCATION_DECK,0,1,nil)
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 
	end
end
function c44480011.sop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44480011.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_TRAP+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
	end
end