--祸摆启生者 玛丽
function c11614422.initial_effect(c)
	--special summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_HAND)
	e0:SetCondition(c11614422.hspcon)
	c:RegisterEffect(e0)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c11614422.spcon)
	c:RegisterEffect(e1)
	--summon&spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,11614422)
	e2:SetCost(c11614422.thcost)
	e2:SetTarget(c11614422.thtg)
	e2:SetOperation(c11614422.thop)
	c:RegisterEffect(e2)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e4:SetCountLimit(1)
	e4:SetTarget(c11614422.cttg)
	e4:SetOperation(c11614422.ctop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)
	--spsummonlimit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTargetRange(0,1)
	e6:SetCondition(c11614422.sumcona)
	e6:SetTarget(c11614422.sumlimit)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetTargetRange(1,0)
	e7:SetCondition(c11614422.sumconb)
	c:RegisterEffect(e7)
	--leave
	local e8=Effect.CreateEffect(c)
	e8:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_LEAVE_FIELD)
	e8:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e8:SetCountLimit(1,11614522+EFFECT_COUNT_CODE_DUEL)
	e8:SetCondition(c11614422.lecon)
	e8:SetTarget(c11614422.letg)
	e8:SetOperation(c11614422.leop)
	c:RegisterEffect(e8)
end
function c11614422.hspcon(e,c)
	if c==nil then return true end
	local tp=e:GetHandler():GetControler()
	return Duel.IsExistingMatchingCard(c11614422.hspfil,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and (Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 or not e:GetHandler():IsLocation(LOCATION_HAND))
end
function c11614422.hspfil(c)
	return c:IsSetCard(0xdaf) and not c:IsDisabled()
end

function c11614422.spcon(e,c)
	local tp=e:GetHandler():GetControler()
	return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 or not e:GetHandler():IsLocation(LOCATION_HAND)
end
function c11614422.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end

function c11614422.filter(c,e,tp)
	return c:IsSetCard(0xdaf) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c11614422.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c11614422.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c11614422.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c11614422.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
			local tc=g:GetFirst()
			Duel.SpecialSummon(tc,0,tp,1-tp,false,false,POS_FACEUP)
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_CANNOT_TRIGGER)
			e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e3:SetRange(LOCATION_MZONE)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e3)
	end
end
function c11614422.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsControlerCanBeChanged() end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,e:GetHandler(),1,0,0)
end
function c11614422.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then Duel.GetControl(c,1-tp) end
end
function c11614422.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_HAND) and not c:IsSetCard(0xdaf)
end
function c11614422.sumcona(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():GetControler()~=e:GetHandler():GetOwner()
end
function c11614422.sumconb(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():GetControler()==e:GetHandler():GetOwner()
end
function c11614422.lecon(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():GetPreviousControler()~=e:GetHandler():GetOwner()
end

function c11614422.filter2(c,e,tp)
	return c:IsSetCard(0xdaf) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c11614422.letg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11614422.filter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c11614422.leop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c11614422.filter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,nil,e,tp)
	local mt=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ct>mt then ct=mt end
	if ct>0 then
		local g=Duel.SelectMatchingCard(tp,c11614422.filter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,ct,nil,e,tp)
		local tc=g:GetFirst()
		while tc do
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_CANNOT_TRIGGER)
			e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e3:SetRange(LOCATION_MZONE)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e3)
			tc=g:GetNext()
		end
	end
end