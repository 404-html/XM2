--花物语-花语千念-
function c65050040.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,65050040)
	e1:SetTarget(c65050040.target)
	e1:SetOperation(c65050040.activate)
	c:RegisterEffect(e1)
end
function c65050040.filter(c)
	return c:IsSetCard(0x6da7) and c:IsFaceup()
end
function c65050040.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingTarget(c65050040.filter,tp,LOCATION_MZONE,0,1,nil)
	local b2=Duel.GetTurnPlayer()~=tp and Duel.IsExistingTarget(c65050040.filter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil)
	if chk==0 then return b1 or b2 end
	local m=2
	if b1 and b2 then
		m=Duel.SelectOption(tp,aux.Stringid(65050040,0),aux.Stringid(65050040,1))
	elseif b1 then
		m=0
	elseif b2 then
		m=1
	end
	e:SetLabel(m)
	if m==0 then
		local g=Duel.SelectTarget(tp,c65050040.filter,tp,LOCATION_MZONE,0,1,1,nil)
	elseif m==1 then
		e:SetCategory(CATEGORY_TOHAND)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g1=Duel.SelectTarget(tp,c65050040.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g2=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
		g1:Merge(g2)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g1,2,0,0)
	end
end
function c65050040.activate(e,tp,eg,ep,ev,re,r,rp)
	local m=e:GetLabel()
	if m==0 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
		--actlimit
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e2:SetCode(EFFECT_CANNOT_ACTIVATE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			e2:SetTargetRange(0,1)
			e2:SetValue(c65050040.aclimit)
			e2:SetCondition(c65050040.actcon)
			tc:RegisterEffect(e2)
		end
	elseif m==1 then
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
		end
	end
end
function c65050040.aclimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
function c65050040.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler()
end