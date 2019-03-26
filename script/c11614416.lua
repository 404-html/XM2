--祸摆统治者 安娜
function c11614416.initial_effect(c)
	--special summon
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_HAND)
	e0:SetCondition(c11614416.hspcon)
	c:RegisterEffect(e0)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c11614416.spcon)
	c:RegisterEffect(e1)
	--summon&spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,11614416)
	e2:SetTarget(c11614416.thtg)
	e2:SetOperation(c11614416.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e4:SetCountLimit(1)
	e4:SetTarget(c11614416.cttg)
	e4:SetOperation(c11614416.ctop)
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
	e6:SetCondition(c11614416.sumcona)
	e6:SetTarget(c11614416.sumlimit)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetTargetRange(1,0)
	e7:SetCondition(c11614416.sumconb)
	c:RegisterEffect(e7)
	--leave
	local e8=Effect.CreateEffect(c)
	e8:SetCategory(CATEGORY_CONTROL)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_LEAVE_FIELD)
	e8:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e8:SetCondition(c11614416.lecon)
	e8:SetTarget(c11614416.letg)
	e8:SetOperation(c11614416.leop)
	c:RegisterEffect(e8)
end
function c11614416.hspcon(e,c)
	if c==nil then return true end
	local tp=e:GetHandler():GetControler()
	return Duel.IsExistingMatchingCard(c11614416.hspfil,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and (Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 or not e:GetHandler():IsLocation(LOCATION_HAND))
end
function c11614416.hspfil(c)
	return c:IsSetCard(0xdaf) and not c:IsDisabled()
end

function c11614416.spcon(e,c)
	local tp=e:GetHandler():GetControler()
	return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 or not e:GetHandler():IsLocation(LOCATION_HAND)
end

function c11614416.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:GetControler()~=tp and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c11614416.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then Duel.GetControl(tc,tp,PHASE_END,1) end
end
function c11614416.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsControlerCanBeChanged() end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,e:GetHandler(),1,0,0)
end
function c11614416.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then Duel.GetControl(c,1-tp) end
end
function c11614416.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_HAND) and not c:IsSetCard(0xdaf)
end
function c11614416.sumcona(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():GetControler()~=e:GetHandler():GetOwner()
end
function c11614416.sumconb(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():GetControler()==e:GetHandler():GetOwner()
end
function c11614416.lecon(e,tp,eg,ep,ev,re,r,rp,chk)
	return e:GetHandler():GetPreviousControler()~=e:GetHandler():GetOwner()
end
function c11614416.filter2(c,tp)
	return c:IsControlerCanBeChanged() and c:GetOwner()~=tp
end
function c11614416.letg(e,tp,eg,ep,ev,re,r,rp,chk)
	 if chk==0 then return Duel.IsExistingMatchingCard(c11614416.filter2,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,0,0)
end
function c11614416.leop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	local sg=g:Filter(c11614416.filter2,nil,tp)
	if sg:GetCount()>0 then
		Duel.GetControl(sg,tp,RESET_PHASE+PHASE_END,1)
	end
end