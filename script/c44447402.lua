--百夜·随风的歌唱少女
function c44447402.initial_effect(c)
	c:EnableReviveLimit()
	--sset
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44447402,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_ONFIELD+LOCATION_HAND)
	e1:SetCountLimit(1,44447402)
	e1:SetCost(c44447402.cost)
	e1:SetTarget(c44447402.target)
	e1:SetOperation(c44447402.operation)
	c:RegisterEffect(e1)
	--ritual material
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	e11:SetValue(1)
	c:RegisterEffect(e11)
end
--sset
function c44447402.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c44447402.filter(c)
	return bit.band(c:GetType(),0x81)==0x81 and not c:IsForbidden() and not c:IsCode(44447402)
end
function c44447402.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44447402.filter,tp,LOCATION_DECK,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44447402.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c44447402.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
		Duel.ConfirmCards(1-tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    tc:RegisterEffect(e1)
		local fid=e:GetHandler():GetFieldID()
        tc:RegisterFlagEffect(44447402,RESET_EVENT+0x1fe0000,0,1,fid)
		local e11=Effect.CreateEffect(e:GetHandler())
		e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e11:SetCode(EVENT_PHASE+PHASE_END)
		e11:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e11:SetCountLimit(1)
		e11:SetLabel(fid)
		e11:SetLabelObject(tc)
		e11:SetCondition(c44447402.tgcon)
		e11:SetOperation(c44447402.tgop)
		e11:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e11,tp)

	end
end
function c44447402.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c44447402.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc:GetFlagEffectLabel(44447402)==e:GetLabel()
end
function c44447402.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Destroy(tc,REASON_EFFECT)
end