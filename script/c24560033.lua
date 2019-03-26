--冷杉剑士
function c24560033.initial_effect(c)
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24560033,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c24560033.target)
	e1:SetOperation(c24560033.operation)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24560033,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetCountLimit(1,24560033)
	e3:SetCondition(c24560033.tgcon)
	e3:SetTarget(c24560033.tgtg)
	e3:SetOperation(c24560033.tgop)
	c:RegisterEffect(e3)
end
function c24560033.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c24560033.fil3,tp,LOCATION_REMOVED,0,nil)
	if g:GetCount()>=1 then
		Duel.ConfirmCards(1-tp,g)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local tg=g:RandomSelect(1-tp,1)
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
	end
end
function c24560033.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c24560033.fil3,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_REMOVED)
end
function c24560033.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c24560033.fil3(c)
	return c:IsFacedown()
end
function c24560033.fil1(c)
	return c:IsRace(RACE_PLANT)
end
function c24560033.fil2(c,spcard)
	return c:IsCode(spcard:GetCode())
end
function c24560033.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_DECK,0,1,nil) and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,nil,0,LOCATION_DECK)
end
function c24560033.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_DECK,0,1,nil) or not Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_DECK,0,1,nil) then return end
	local g=Duel.GetMatchingGroup(c24560033.fil1,tp,LOCATION_DECK,0,nil)
	local dcount=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local seq=-1
	local tc=g:GetFirst()
	local spcard=nil
	while tc do
		if tc:GetSequence()>seq then 
			seq=tc:GetSequence()
			spcard=tc
		end
		tc=g:GetNext()
	end
	if seq==-1 then
		Duel.ConfirmDecktop(tp,dcount)
		Duel.ShuffleDeck(tp)
		return 
	end
	Duel.ConfirmDecktop(tp,dcount-seq)
	if spcard:IsAbleToGrave() then
		Duel.DisableShuffleCheck()
		local spgrop=Duel.GetMatchingGroup(c24560033.fil2,tp,LOCATION_DECK,0,nil,spcard)
		if dcount-seq==1 then
		Duel.SendtoGrave(spgrop,nil,REASON_EFFECT) 
		else
			local rmgrop=Duel.GetDecktopGroup(tp,dcount-seq-1)
			Duel.SendtoGrave(spgrop,nil,REASON_EFFECT)
			Duel.Remove(rmgrop,POS_FACEDOWN,REASON_EFFECT+REASON_REVEAL)
		end
	else
		local rmgrop2=Duel.GetDecktopGroup(tp,dcount-seq)
		Duel.Remove(rmgrop2,POS_FACEDOWN,REASON_EFFECT+REASON_REVEAL)
	end
end