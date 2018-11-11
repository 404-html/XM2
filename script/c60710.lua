--禁忌「Cranberry Trap」（红莓陷阱）
function c60710.initial_effect(c)
	--add code
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_ADD_CODE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetValue(60700)
	c:RegisterEffect(e0)	
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c60710.cost)
	e1:SetTarget(c60710.target)
	e1:SetOperation(c60710.activate)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCost(c60710.cost)
	e3:SetTarget(c60710.target2)
	e3:SetOperation(c60710.activate)
	c:RegisterEffect(e3)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60710,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c60710.setcon)
	e2:SetTarget(c60710.sptg)
	e2:SetOperation(c60710.spop)
	c:RegisterEffect(e2)
	--act in hand
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e4:SetCondition(c60710.handcon)
	c:RegisterEffect(e4)
end
function c60710.handcon(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	return g:GetCount()>0 and g:FilterCount(Card.IsSetCard,nil,0x813)==g:GetCount()
end
function c60710.filter(c,tp,ep)
	return c:IsLocation(LOCATION_MZONE) and c:IsReleasable()
end
function c60710.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return eg:GetCount()==1 and tc:IsReleasable() end
	Duel.Release(tc,REASON_COST)
	e:SetLabel(tc:GetOwner())
end
function c60710.filter22(c,e,tp)
	return c:IsCode(60700) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c60710.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return c60710.filter(tc,tp,ep) and eg:GetCount()==1 and Duel.IsExistingMatchingCard(c60710.filter22,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c60710.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c60710.filter22,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local ap=e:GetLabel()
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,ap,false,false,POS_FACEUP)
	end
end
function c60710.filter2(c,tp)
	return c:IsLocation(LOCATION_MZONE)  and c:IsReleasable()
end
function c60710.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c60710.filter2,1,nil,tp) and eg:GetCount()==1 and Duel.IsExistingMatchingCard(c60710.filter22,tp,LOCATION_DECK,0,1,nil,e,tp) end
	local g=eg:Filter(c60710.filter2,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c60710.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:GetPreviousControler()==tp
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c60710.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,60711,0,0x814,2000,2000,7,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,0,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60710.spop(e,tp,eg,ep,ev,re,r,rp)
	local bbc=0
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.IsPlayerCanSpecialSummonMonster(tp,60711,0,0x814,2000,2000,7,RACE_FIEND,ATTRIBUTE_DARK) then
		c:AddMonsterAttribute(TYPE_EFFECT)
		if Duel.SpecialSummonStep(c,0,tp,tp,true,false,POS_FACEUP) then 
			bbc=bbc+1
			c:AddMonsterAttributeComplete()
			Duel.SpecialSummonComplete()
		end 
	end
	if bbc>0 then 
		local sg=e:GetHandler():GetColumnGroup()
		if Duel.Destroy(sg,REASON_EFFECT)<1 then 
			Duel.Damage(1-tp,495,REASON_EFFECT)			
		end
	end 
end
