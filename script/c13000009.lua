--虚拟歌姬 粉丝
function c13000009.initial_effect(c)
	c:EnableReviveLimit()
	--connot special summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e0)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13000009,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA)
	e1:SetCountLimit(1,13000009)
	e1:SetCondition(c13000009.con1)
	e1:SetCost(c13000009.spcost)
	e1:SetTarget(c13000009.sptg)
	e1:SetOperation(c13000009.spop)
	c:RegisterEffect(e1)
	local e1_1=e1:Clone()
	e1_1:SetType(EFFECT_TYPE_QUICK_O)
	e1_1:SetCode(EVENT_FREE_CHAIN)
	e1_1:SetHintTiming(0,TIMING_END_PHASE)
	e1_1:SetCondition(c13000009.con2)
	c:RegisterEffect(e1_1)
	--special summon from GY
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(13000009,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c13000009.gspcon)
	e3:SetTarget(c13000009.gsptg)
	e3:SetOperation(c13000009.gspop)
	c:RegisterEffect(e3)
	--buff
	--disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c13000009.distg)
	c:RegisterEffect(e2)
	--spsummon limit
	local e2_1=e2:Clone()
	e2_1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2_1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2_1:SetTargetRange(1,0)
	e2_1:SetTarget(c13000009.sumlimit)
	c:RegisterEffect(e2_1)
	--immune
	local e2_2=e2:Clone()
	e2_2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2_2:SetTarget(c13000009.etg)
	e2_2:SetValue(c13000009.efilter)
	c:RegisterEffect(e2_2)
end
function c13000009.con1(e,tp,eg,ep,ev,re,r,rp)
	local gct=Duel.GetMatchingGroupCount(c13000009.ifilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)
	local mgct=Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)
	return mgct>0 and gct>0 and mgct==gct and not Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000009.con2(e,tp,eg,ep,ev,re,r,rp)
	local gct=Duel.GetMatchingGroupCount(c13000009.ifilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)
	local mgct=Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)
	return mgct>0 and gct>0 and mgct==gct and Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000009.ifilter(c)
	return c:IsSetCard(0x130) and c:IsFaceup()
end
function c13000009.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c13000009.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,true) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13000009.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then 
		Duel.SpecialSummon(c,SUMMON_TYPE_SYNCHRO,tp,tp,true,true,POS_FACEUP)
		c:CompleteProcedure()
	end
end
function c13000009.gspfilter(c,e,tp)
	return c:IsSetCard(0x130) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsFaceup()
end
function c13000009.gspcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetFlagEffect(tp,13000009)==0
end
function c13000009.gsptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c13000009.gspfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c13000009.gspfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.RegisterFlagEffect(tp,13000009,RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c13000009.gspfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c13000009.gspop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then 
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c13000009.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLocation(LOCATION_EXTRA)
end
function c13000009.distg(e,c)
	return (c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT) and not c:IsSetCard(0x130)
end
function c13000009.etg(e,c)
	return c:IsSetCard(0x130) and e:GetOwner()~=c
end
function c13000009.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()-- and te:IsActiveType(TYPE_MONSTER)
end
