--相似的灵魂
function c21520095.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c21520095.target)
	e1:SetOperation(c21520095.activate)
	c:RegisterEffect(e1)
end
function c21520095.filter(c,e,tp,tc)
	if not tc then
		return c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:IsAbleToHand()
	else
		return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetTextAttack()==tc:GetTextAttack() and c:GetTextDefense()==tc:GetTextDefense()
	end
end
function c21520095.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c21520095.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c21520095.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectTarget(tp,c21520095.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
end
function c21520095.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local ops=2
		local b1=Duel.IsExistingMatchingCard(c21520095.filter,tp,LOCATION_HAND,0,1,nil,e,tp,tc) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
		local b2=Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		if b1 and b2 and not tc:IsType(TYPE_LINK) then 
			ops=Duel.SelectOption(tp,aux.Stringid(21520095,0),aux.Stringid(21520095,1))
		else 
			ops=1
			Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(21520095,1))
		end
		if ops==0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=Duel.SelectMatchingCard(tp,c21520095.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,tc)
			sg:AddCard(tc)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		elseif ops==1 then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
			local dc=Duel.GetDecktopGroup(tp,1):GetFirst()
			if Duel.Draw(tp,1,REASON_EFFECT)~=0 and Duel.SelectYesNo(tp,aux.Stringid(21520095,2)) then
				Duel.ConfirmCards(1-tp,dc)
				if dc:GetTextAttack()==tc:GetTextAttack() and dc:GetTextDefense()==tc:GetTextDefense() then
					e:GetHandler():CancelToGrave()
					Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
					Duel.ConfirmCards(1-tp,e:GetHandler())
				else
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
					local tdg=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_HAND,0,1,1,nil)
					Duel.SendtoDeck(tdg,nil,1,REASON_EFFECT)
				end
			else
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
				local tdg=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_HAND,0,1,1,nil)
				Duel.SendtoDeck(tdg,nil,1,REASON_EFFECT)
			end
		end
	end
end
