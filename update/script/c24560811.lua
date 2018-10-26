--雛群
function c24560811.initial_effect(c)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24560811,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c24560811.hdcon)
	e3:SetTarget(c24560811.hdtg)
	e3:SetOperation(c24560811.hdop)
	c:RegisterEffect(e3)
end
function c24560811.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,24560810,0,0x4011,400,400,1,RACE_WINDBEAST,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c24560811.hdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,24560810,0,0x4011,400,400,1,RACE_WINDBEAST,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,24560810)
		if Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)~=0 then
			if Duel.GetFlagEffect(tp,24560811)~=0 then return false end
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetDescription(aux.Stringid(24560811,1))
				e1:SetType(EFFECT_TYPE_FIELD)
				e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
				e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
				e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_WINDBEAST))
				e1:SetReset(RESET_PHASE+PHASE_END)
				Duel.RegisterEffect(e1,tp)
				Duel.RegisterFlagEffect(tp,24560811,RESET_PHASE+PHASE_END,0,1)
		end
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c24560811.sxlim)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c24560811.sxlim(e,c)
	return not c:IsRace(RACE_WINDBEAST)
end
function c24560811.cfil(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c24560811.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c24560811.cfil,1,nil)
end