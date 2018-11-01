--猛毒性 交翼
function c24762460.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,3,c24762460.lcheck)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24762460,0))
	e2:SetRange(LOCATION_MZONE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetTarget(c24762460.seqtg)
	e2:SetOperation(c24762460.seqop)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c24762460.dircon)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24762460,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,24762460)
	e3:SetTarget(c24762460.rmtg)
	e3:SetOperation(c24762460.rmop)
	c:RegisterEffect(e3)
end
function c24762460.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c24762460.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
	if Duel.SendtoHand(tc,nil,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local og=Duel.GetOperatedGroup()
		local oc=og:GetFirst()
		if oc then
		oc:RegisterFlagEffect(24762460,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY+RESET_OPPO_TURN,0,1)
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(24762460,2))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		e1:SetCountLimit(1)
		e1:SetLabelObject(og)
		e1:SetCondition(c24762460.retcon)
		e1:SetOperation(c24762460.retop)
		Duel.RegisterEffect(e1,tp)
	end
	end
end
function c24762460.retfilter(c)
	return c:GetFlagEffect(24762460)~=0
end
function c24762460.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c24762460.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(c24762460.retfilter,nil)
	if sg:GetCount()>1 and sg:GetClassCount(Card.GetPreviousControler)==1 then
		local ft=Duel.GetLocationCount(sg:GetFirst():GetPreviousControler(),LOCATION_MZONE)
		if ft==1 then
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(24762460,2))
			local tc=sg:Select(tp,1,1,nil):GetFirst()
			Duel.ReturnToField(tc)
			sg:RemoveCard(tc)
		end
	end
end
function c24762460.dircon(e)
	local tp=e:GetHandlerPlayer()
	local gc=e:GetHandler():GetColumnGroup():Filter(Card.IsControler,nil,1-tp):FilterCount(Card.IsType,nil,TYPE_MONSTER)
	if gc==0 then return true end
end
function c24762460.filter(c,ggc)
	local p=ggc:GetControler()
	local zone=bit.band(ggc:GetLinkedZone(),0x1f)
	return Duel.GetLocationCount(p,LOCATION_MZONE,p,LOCATION_REASON_CONTROL,zone)>0
end
function c24762460.seqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ggc=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c24762460.filter,tp,LOCATION_MZONE,0,1,nil,ggc) end
end
function c24762460.seqop(e,tp,eg,ep,ev,re,r,rp)
	local ggc=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local p=ggc:GetControler()
	local zone=bit.band(ggc:GetLinkedZone(),0x1f)
	if Duel.GetLocationCount(p,LOCATION_MZONE,p,LOCATION_REASON_CONTROL,zone)>0 then
		local s=0
		if ggc:IsControler(tp) then
			local flag=bit.bxor(zone,0xff)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
			s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,flag)
		end
		local nseq=0
		if s==1 then nseq=0
		elseif s==2 then nseq=1
		elseif s==4 then nseq=2
		elseif s==8 then nseq=3
		else nseq=4 end
		Duel.MoveSequence(ggc,nseq)
	end
end
function c24762460.lcheck(g,lc)
	return g:IsExists(Card.IsSetCard,1,nil,0x9390)
end