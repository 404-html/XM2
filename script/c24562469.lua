--猛毒性 音切
function c24562469.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetDescription(aux.Stringid(24562469,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(c24562469.damtg)
	e1:SetOperation(c24562469.damop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCondition(c24562469.damcon)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(24562469,1))
	e5:SetCategory(CATEGORY_TODECK)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_CHAINING)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CARD_TARGET)
	e5:SetCondition(c24562469.lvcon)
	e5:SetTarget(c24562469.lvtg)
	e5:SetOperation(c24562469.lvop)
	c:RegisterEffect(e5)
end
function c24562469.tdfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x1390) and c:IsAbleToDeck()
end
function c24562469.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c24562469.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c24562469.tdfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c24562469.tdfilter,tp,LOCATION_REMOVED,0,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c24562469.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()<=0 then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct>0 then
		Duel.BreakEffect()
		local sum=0
		local sum2=0
		local sum3=0
		local tc=g:GetFirst()
		while tc do
			if tc:IsType(TYPE_XYZ) then sum=sum+tc:GetRank()
			elseif tc:IsType(TYPE_LINK) then sum2=sum2+tc:GetLink()
			else sum3=sum3+tc:GetLevel() end
			tc=g:GetNext()
		end
		local exsum=sum+sum2+sum3
		if exsum>0 and c:IsFaceup() and Duel.SelectYesNo(tp,aux.Stringid(24562469,1)) then 
			if exsum==1 then
			lv=Duel.AnnounceNumber(tp,1)
			elseif exsum==2 then
			lv=Duel.AnnounceNumber(tp,1,2)
			elseif exsum==3 then
			lv=Duel.AnnounceNumber(tp,1,2,3)
			elseif exsum==4 then
			lv=Duel.AnnounceNumber(tp,1,2,3,4)
			elseif exsum==5 then
			lv=Duel.AnnounceNumber(tp,1,2,3,4,5)
			elseif exsum==6 then
			lv=Duel.AnnounceNumber(tp,1,2,3,4,5,6)
			elseif exsum==7 then
			lv=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7)
			elseif exsum==8 then
			lv=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8)
			elseif exsum>=9 then
			lv=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9)
			end
			local e1=Effect.CreateEffect(c)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_LEVEL)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(lv)
			c:RegisterEffect(e1)
		end
	end
end
function c24562469.lvcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsContains(c)
end
function c24562469.damcon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetHandler():IsSetCard(0x1390)
end
function c24562469.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(400)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,400)
end
function c24562469.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end