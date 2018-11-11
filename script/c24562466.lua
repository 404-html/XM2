--猛毒性 蠼螋
function c24562466.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c24562466.e2con)
	e2:SetTarget(c24562466.sptg)
	e2:SetOperation(c24562466.spop)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24562466,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,24562466)
	e1:SetCondition(c24562466.e1con)
	e1:SetTarget(c24562466.thtg)
	e1:SetOperation(c24562466.thop)
	c:RegisterEffect(e1)
end
function c24562466.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3
		and Duel.GetDecktopGroup(tp,3):FilterCount(Card.IsAbleToHand,nil)>0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c24562466.thfilter(c)
	return c:IsSetCard(0x9390) and c:IsAbleToHand()
end
function c24562466.thop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.ConfirmDecktop(p,3)
	local g=Duel.GetDecktopGroup(p,3)
	if g:GetCount()>0 and g:IsExists(c24562466.thfilter,1,nil) and Duel.SelectYesNo(p,aux.Stringid(24562466,1)) then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(p,c24562466.thfilter,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-p,sg)
		Duel.ShuffleHand(p)
		g:RemoveCard(sg:GetFirst())
		rg=g:Filter(c24562466.rf,nil)
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	end
	Duel.ShuffleDeck(p)
end
function c24562466.rf(c)
	return c:IsAbleToRemove()
end
function c24562466.e1con(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetHandler():IsSetCard(0x9390)
end
function c24562466.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c24562466.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c24562466.c2fil(c)
	return c:IsFaceup() and c:IsDualState()
end
function c24562466.e2con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c24562466.c2fil,1,nil)
end