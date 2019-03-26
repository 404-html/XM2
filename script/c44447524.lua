--始祖龙 苍龙
function c44447524.initial_effect(c)
	c:SetUniqueOnField(1,0,44447524)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsXyzType,TYPE_NORMAL),9,2)
	c:EnableReviveLimit()
	--xyz
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetDescription(aux.Stringid(44447524,1))
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c44447524.xyzcon)
	e1:SetOperation(c44447524.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--Tohand
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44447524,2))
	e11:SetCategory(CATEGORY_TOHAND)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e11:SetCode(EVENT_DAMAGE_STEP_END)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCondition(c44447524.atkcon)
	e11:SetTarget(c44447524.thtg)
	e11:SetOperation(c44447524.thop)
	c:RegisterEffect(e11)
	--immune 
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_SINGLE)
	e21:SetCode(EFFECT_IMMUNE_EFFECT)
	e21:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e21:SetRange(LOCATION_MZONE)
	e21:SetCondition(c44447524.ctcon1)
	e21:SetValue(c44447524.efilter1)
	c:RegisterEffect(e21)
	local e22=e21:Clone()
	e22:SetCondition(c44447524.ctcon2)
	e22:SetValue(c44447524.efilter2)
	c:RegisterEffect(e22)
	local e32=e22:Clone()
	e32:SetCondition(c44447524.ctcon3)
	e32:SetValue(c44447524.efilter3)
	c:RegisterEffect(e32)
end
function c44447524.xyzfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_MONSTER)
end
function c44447524.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,0x4)<=0 then return false end
	return Duel.IsExistingMatchingCard(c44447524.xyzfilter,tp,LOCATION_SZONE,0,3,nil) and Duel.GetLocationCountFromEx(tp)>0
end
function c44447524.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c44447524.xyzfilter,tp,LOCATION_SZONE,0,3,3,nil)
	c:SetMaterial(g)
	Duel.Overlay(c,g)
end

--Tohand
function c44447524.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler()
end
function c44447524.thfilter(c)
	return c:IsAbleToHand()
end
function c44447524.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
	if chk==0 then return c:GetOverlayGroup():Filter(c44447524.thfilter,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c44447524.thop(e,tp,eg,ep,ev,re,r,rp)
      local c=e:GetHandler()
	  local g=c:GetOverlayGroup()
	  if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
	    local tc=g:FilterSelect(tp,c44447524.thfilter,1,1,nil,e,tp):GetFirst()
	    if not tc then return end 
		if tc then 
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		end
	 end
end
--immune 
function c44447524.ctcon1(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_MONSTER)
end
function c44447524.ctcon2(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_SPELL)
end
function c44447524.ctcon3(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_TRAP)
end
function c44447524.efilter1(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c44447524.efilter2(e,te)
	return te:IsActiveType(TYPE_SPELL) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c44447524.efilter3(e,te)
	return te:IsActiveType(TYPE_TRAP) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end