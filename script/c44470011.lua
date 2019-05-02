--真红眼黑炎骑士
function c44470011.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,2,c44470011.ovfilter,aux.Stringid(44470011,0))
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44470011,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)

	e1:SetCost(c44470011.cost)
	e1:SetTarget(c44470011.eqtg)
	e1:SetOperation(c44470011.eqop)
	c:RegisterEffect(e1)
end
function c44470011.ovfilter(c)
	return c:IsFaceup() and c:GetRank()==7 and not c:IsCode(44470011)
end
--equip
function c44470011.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c44470011.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470011.sfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil)
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c44470011.eqlimit(e,c)
	return e:GetOwner()==c
end
function c44470011.sfilter(c)
	return c:IsSetCard(0x3b) and c:IsType(TYPE_MONSTER)
end
function c44470011.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsFaceup() or not c:IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.SelectMatchingCard(tp,c44470011.sfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil):GetFirst()
	if not tc or not Duel.Equip(tp,tc,c,true) then return end
	local atk=tc:GetAttack()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(c44470011.eqlimit)
	tc:RegisterEffect(e1)
	local cid=c:CopyEffect(tc:GetOriginalCodeRule(),RESET_EVENT+0x1fe0000)
end
