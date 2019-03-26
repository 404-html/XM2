--赠物的瓜
function c24560034.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24560034,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,24560034)
	e1:SetCost(c24560034.cost)
	e1:SetOperation(c24560034.operation)
	c:RegisterEffect(e1)
end
function c24560034.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c24560034.drcon1)
	e2:SetTarget(c24560034.tg1)
	e2:SetOperation(c24560034.regop)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetCondition(c24560034.drcon2)
	e3:SetOperation(c24560034.drop)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c24560034.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local op=Duel.GetLP(tp)
	local yp=Duel.GetLP(1-tp)
	if op>1225 then opr=op-1225
		elseif op<1225 then opr=1225-op
		elseif op==1225 then opr=0
	end
	if yp>1225 then tpr=yp-1225
		elseif yp<1225 then tpr=1225-yp
		elseif yp==1225 then tpr=0
	end
	e:SetValue(0)
	if Duel.GetFlagEffect(tp,85115440)==0 then
	if tpr==opr then return false
		elseif tpr>opr then
		e:SetValue(1)
		if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDiscardDeck(1-tp,1) end
		elseif opr>tpr then
		e:SetValue(2)
		if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) and Duel.IsPlayerCanDiscardDeck(tp,1) end
	end
	if e:GetValue()==1 then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	elseif e:GetValue()==2 then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
	end
	elseif Duel.GetFlagEffect(tp,85115440)>0 then
	local n=Duel.GetFlagEffect(tp,24560034)
	if tpr==opr then return false
		elseif tpr>opr then
		e:SetValue(1)
		if chk==0 then return Duel.IsPlayerCanDraw(tp,n) and Duel.IsPlayerCanDiscardDeck(1-tp,n) end
		elseif opr>tpr then
		e:SetValue(2)
		if chk==0 then return Duel.IsPlayerCanDraw(1-tp,n) and Duel.IsPlayerCanDiscardDeck(tp,n) end
	end
	if e:GetValue()==1 then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,n)
	elseif e:GetValue()==2 then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,n)
	end 
	end
end
function c24560034.drcon1(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsHasCategory(CATEGORY_TOGRAVE)
end
function c24560034.drcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,24560034)>0
end
function c24560034.drop(e,tp,eg,ep,ev,re,r,rp)
	local n=Duel.GetFlagEffect(tp,24560034)
	Duel.ResetFlagEffect(tp,24560034)
	if Duel.GetFlagEffect(tp,24560032)~=0 and Duel.IsPlayerCanDraw(1-tp,n) and Duel.IsPlayerCanDiscardDeck(tp,n) then
		Duel.Draw(1-tp,n,REASON_EFFECT)
		Duel.ConfirmDecktop(tp,n)
		local g=Duel.GetDecktopGroup(tp,n)
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
	elseif Duel.GetFlagEffect(tp,24560033)~=0 and Duel.IsPlayerCanDraw(tp,n) and Duel.IsPlayerCanDiscardDeck(1-tp,n) then
		Duel.Draw(tp,n,REASON_EFFECT)
		Duel.ConfirmDecktop(1-tp,n)
		local g=Duel.GetDecktopGroup(1-tp,n)
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
	end
end
function c24560034.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(tp,24560034,RESET_CHAIN,0,1)
	if e:GetValue()==1 then 
		Duel.RegisterFlagEffect(tp,24560033,RESET_CHAIN,0,1)
	elseif e:GetValue()==2 then
		Duel.RegisterFlagEffect(tp,24560032,RESET_CHAIN,0,1)
	end
end
function c24560034.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end