--猛毒性 Ah·Re·Dos
function c24762457.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,24762457)
	e2:SetCost(c24762457.e2cost)
	e2:SetTarget(c24762457.e2tg)
	e2:SetOperation(c24762457.e2op)
	c:RegisterEffect(e2)
end
function c24762457.e2cf(c)
	return c:IsSetCard(0x9390) and c:IsType(TYPE_MONSTER) and c:IsReleasable()
end
function c24762457.e2cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(0)
	if chk==0 then return Duel.IsExistingMatchingCard(c24762457.e2cf,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,c24762457.e2cf,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.Release(g,REASON_COST)
	if (g:GetFirst():IsCode(24562468) or g:GetFirst():IsCode(24762458)) and Duel.Release(g,REASON_COST)~=0 then
		e:SetLabel(1)
	end
end
function c24762457.e2til(c)
	return c:IsSetCard(0x9390) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c24762457.df(c)
	return c:IsSetCard(0x9390)
end
function c24762457.e2tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local gc=Duel.GetMatchingGroupCount(c24762457.df,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(c24762457.e2til,tp,LOCATION_DECK,0,1,nil) and gc>0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,gc*400)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c24762457.e2op(e,tp,eg,ep,ev,re,r,rp)
	local gc=Duel.GetMatchingGroupCount(c24762457.df,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	local g=Duel.GetMatchingGroup(c24762457.e2til,tp,LOCATION_DECK,0,nil)
	if g:GetCount()~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,1,nil)
		if Duel.SendtoGrave(sg,REASON_EFFECT)~=0 then return true end
		Duel.IsPlayerCanDiscardDeck(tp,2) 
		if e:GetLabel()==1 and Duel.SelectYesNo(tp,aux.Stringid(24762457,0)) then
			local g1=Duel.GetDecktopGroup(tp,2)
			if Duel.SendtoGrave(g1,REASON_EFFECT)~=0 then
				Duel.BreakEffect()
				local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
				Duel.Damage(p,gc*400,REASON_EFFECT)
			end
		else Duel.BreakEffect()
			 local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
			 Duel.Damage(p,gc*400,REASON_EFFECT)
		end
	end
end