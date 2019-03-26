--蓝瞳器·弦音悲弓
function c44480075.initial_effect(c)
	--Activate(spsummon)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,44480075+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c44480075.con)
	e1:SetOperation(c44480075.activate)
	c:RegisterEffect(e1)
	--atk
	local e20=Effect.CreateEffect(c)
	e20:SetType(EFFECT_TYPE_EQUIP)
	e20:SetCode(EFFECT_SET_ATTACK_FINAL)
	e20:SetValue(c44480075.value)
	c:RegisterEffect(e20)
	--Direct Attack
	local e31=Effect.CreateEffect(c)
	e31:SetType(EFFECT_TYPE_EQUIP)
	e31:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e31)
	--disable
	local e41=Effect.CreateEffect(c)
	e41:SetType(EFFECT_TYPE_EQUIP)
	e41:SetCode(EFFECT_DISABLE)
	--e41:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e41)
end
function c44480075.spfilter(c,e)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) 
end
function c44480075.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44480075.spfilter,1,nil)
end
function c44480075.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c44480075.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c44480075.aclimit(e,re,tp)
    local tc=re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and not re:GetHandler():IsImmuneToEffect(e)
	and tc:IsSummonType(SUMMON_TYPE_SPECIAL)
end

function c44480075.value(e,c)
	return c:GetAttack()/2
end