--流光✿星落☯
function c90000011.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c90000011.target)
	e1:SetOperation(c90000011.activate)
	c:RegisterEffect(e1)
end
function c90000011.defilter(c)
	return c:IsDestructable() 
end
function c90000011.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000011.defilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD+LOCATION_EXTRA,LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD+LOCATION_EXTRA,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD+LOCATION_EXTRA)
end
function c90000011.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local tc=Duel.SelectMatchingCard(tp,c90000011.defilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD+LOCATION_EXTRA,LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD+LOCATION_EXTRA,1,99,nil)
	if tc:GetCount()>0 then
        local c=e:GetHandler()
	    local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetCode(90000011)
	    e1:SetReset(RESET_EVENT+RESET_CHAIN)
	    e1:SetOperation(function() Duel.Destroy(tc,0x40) end)
		Duel.RegisterEffect(e1,1-tp)
	    Duel.RaiseEvent(c,90000011,e1,0x40,1-tp,1-tp,0)	
	end
end