--蓝瞳器·水晶幕尺
function c44480056.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44480056+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c44480056.target)
	e1:SetOperation(c44480056.activate)
	c:RegisterEffect(e1)
	--cannot be target
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_EQUIP)
	e7:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e7:SetValue(aux.imval1)
	c:RegisterEffect(e7)
	--local e8=e7:Clone()
	--e8:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	--e8:SetValue(aux.tgoval)
	--c:RegisterEffect(e8)
	--disable
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_EQUIP)
	e21:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e21)
	--atkup
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_EQUIP)
	e22:SetCode(EFFECT_UPDATE_ATTACK)
	e22:SetValue(100)
	c:RegisterEffect(e22)
	
end
function c44480056.thfilter(c)
	return c:IsSetCard(0x646) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c44480056.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44480056.thfilter,tp,LOCATION_DECK,0,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c44480056.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c44480056.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>=3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,3,3,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleDeck(tp)
		local tg=sg:RandomSelect(1-tp,1)
		local tc=tg:GetFirst()
		if tc:IsAbleToHand() then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			sg:RemoveCard(tc)
		end
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
