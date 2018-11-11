--☯倒转的天邪鬼
function c140700.initial_effect(c)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(140700,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_HAND)	
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c140700.spcon)
	e2:SetCost(c140700.cost)	
	e2:SetTarget(c140700.target2)
	e2:SetOperation(c140700.plop)
	c:RegisterEffect(e2)		
	local e1=e2:Clone()
	e1:SetCode(EVENT_TO_GRAVE)
	c:RegisterEffect(e1)	
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetDescription(aux.Stringid(140700,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_TODECK)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_HAND)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return e:GetHandler():IsPublic()
	end)
	e3:SetOperation(c140700.retop)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(140700,2))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,140700)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c140700.drtg)
	e4:SetOperation(c140700.drop)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(140700,3))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCountLimit(1,140700)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetTarget(c140700.tg)
	e5:SetOperation(c140700.op)
	c:RegisterEffect(e5)
	--spsummon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(140700,4))
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetCountLimit(1,140700)
	e6:SetCode(EVENT_SUMMON_SUCCESS)
	e6:SetTarget(c140700.rettg)
	e6:SetOperation(c140700.retop2)
	c:RegisterEffect(e6)
end
function c140700.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c140700.spfilter,1,nil,1-tp)
end
function c140700.spfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK) and not c:IsReason(REASON_DRAW)
end
function c140700.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return  not e:GetHandler():IsPublic() end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.ShuffleHand(tp)
end
function c140700.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c140700.spfilter,1,nil,1-tp) end
	local g=eg:Filter(c140700.spfilter,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c140700.filter3(c,e,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK) and not c:IsReason(REASON_DRAW)
		and c:IsRelateToEffect(e) 
end
function c140700.plop(e,tp,eg,ep,ev,re,r,rp)
	local pg=eg:Filter(c140700.filter3,nil,e,1-tp)
	local c=e:GetHandler()
	if e:GetHandler():IsRelateToEffect(e) and pg:GetCount()>0 then
		Duel.SendtoHand(c,1-tp,REASON_EFFECT)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PUBLIC)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		Duel.SendtoDeck(pg,1-tp,2,REASON_EFFECT)
	end
end
function c140700.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),1-tp,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end 
end 
function c140700.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=1
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct) end
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(ct)
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c140700.drop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(Card.IsCode,p,LOCATION_GRAVE,0,nil,81782376)
	Duel.Draw(p,ct,REASON_EFFECT)
end
function c140700.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local lv=e:GetHandler():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(26082117,1))
	e:SetLabel(Duel.AnnounceLevel(tp,1,12,lv))
end
function c140700.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c140700.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c140700.retop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		if Duel.SendtoHand(c,tp,REASON_EFFECT)~=0 then 
		end 
	end 
end 