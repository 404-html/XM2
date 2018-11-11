--百夜·风花雪月
function c44449027.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44449027+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c44449027.cost)
	e1:SetTarget(c44449027.target)
	e1:SetOperation(c44449027.activate)
	c:RegisterEffect(e1)
end
function c44449027.rfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsAttribute(ATTRIBUTE_WIND+ATTRIBUTE_EARTH+ATTRIBUTE_WATER+ATTRIBUTE_DARK)
end
function c44449027.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44449027.rfilter,tp,LOCATION_DECK+LOCATION_ONFIELD,0,1,e:GetHandler()) end
	local rg=Duel.SelectMatchingCard(tp,c44449027.rfilter,tp,LOCATION_DECK+LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
	local rc=rg:GetFirst()
	if rc:IsAttribute(ATTRIBUTE_WIND) then e:SetLabel(1)
	elseif rc:IsAttribute(ATTRIBUTE_EARTH) then e:SetLabel(2)
	elseif rc:IsAttribute(ATTRIBUTE_WATER) then e:SetLabel(3)
	elseif rc:IsAttribute(ATTRIBUTE_DARK) then e:SetLabel(4)
	else e:SetLabel(0)
	end
end

function c44449027.tgfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGrave()
end
function c44449027.efilter(c,e,tp)
	return c:IsCanTurnSet() 
end
function c44449027.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return
	Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) 
	or Duel.IsPlayerCanDraw(tp,1)
	or Duel.IsExistingMatchingCard(c44449027.tgfilter,tp,LOCATION_DECK,0,1,nil)
	or Duel.IsExistingMatchingCard(c44449027.efilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())
	end
end
function c44449027.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 then 
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	    end
	    elseif e:GetLabel()==2 then
		Duel.Draw(tp,1,REASON_EFFECT)
	    elseif e:GetLabel()==3 then  
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	    local g=Duel.SelectMatchingCard(tp,c44449027.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	    if g:GetCount()>0 then
		   Duel.SendtoGrave(g,REASON_EFFECT)
	    end
	    elseif e:GetLabel()==4 then  
		local g=Duel.SelectMatchingCard(tp,c44449027.efilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
		if g:GetCount()>0 then
           Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
		end
	end
end
