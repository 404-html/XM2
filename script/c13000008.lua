--虚拟歌姬 舞台
function c13000008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13000008,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c13000008.target)
	e1:SetOperation(c13000008.activate)
	c:RegisterEffect(e1)
	--change effect type
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(13000008)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
	--immue
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetCondition(c13000008.econ)
	e3:SetValue(c13000008.efilter)
	c:RegisterEffect(e3)
end
function c13000008.thfilter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x130) and c:IsType(TYPE_MONSTER)
end
function c13000008.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SEARCH+CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13000008.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c13000008.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and c:IsRelateToEffect(e) and Duel.SelectYesNo(tp,aux.Stringid(13000008,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c13000008.ifilter(c)
	return c:IsSetCard(0x130) and c:IsFaceup()
end
function c13000008.econ(e)
	local gct=Duel.GetMatchingGroupCount(c13000008.ifilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)
	local mgct=Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)
	return mgct>0 and gct>0 and mgct==gct
end
function c13000008.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
