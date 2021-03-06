--邪神依-青丘九尾
function c44460259.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x677),2)
	c:EnableReviveLimit()
	--sy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44460259,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	--e1:SetCondition(c44460259.xycon)
	e1:SetCost(c44460259.xycost)
	e1:SetTarget(c44460259.xytg)
	e1:SetOperation(c44460259.xyop)
	c:RegisterEffect(e1)
	--Release
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44460259,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,44460259)
	e2:SetCondition(c44460259.scon)
	e2:SetTarget(c44460259.ktg)
	e2:SetOperation(c44460259.kop)
	c:RegisterEffect(e2)


end
--sy
function c44460259.xycost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.PayLPCost(tp,1000)
end
function c44460259.filter(c,tp)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK) and c:IsSetCard(0x677)
end
function c44460259.tfilter(c)
	return c:IsSetCard(0x679) and c:IsAbleToGrave()
end
function c44460259.xycon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460259.filter,1,nil,tp)
end
function c44460259.xytg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsAttribute(ATTRIBUTE_DARK) and tc:IsSetCard(0x677)
	and tc:GetControler()==tp
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>-2
        and Duel.IsExistingMatchingCard(c44460259.tfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_ONFIELD)
	Duel.SetChainLimit(c44460259.climit)
end
function c44460259.xyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44460259.tfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
	if g:GetCount()>0 then
	Duel.SendtoGrave(g,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.ConfirmCards(1-tp,c)
		local e1=Effect.CreateEffect(c)
	    e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
	end
end
function c44460259.climit(e,lp,tp)
	return e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
--Release
function c44460259.sfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) 
end
function c44460259.scon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c44460259.sfilter,1,nil,tp)
end
function c44460259.ktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil)
	and Duel.CheckReleaseGroup(1-tp,nil,1,nil) end
end
function c44460259.kop(e,tp,eg,ep,ev,re,r,rp)
    local g1=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	local g2=Duel.SelectReleaseGroup(1-tp,nil,1,1,nil)
	Duel.Release(g1,REASON_RULE)
	Duel.Release(g2,REASON_RULE)
end
