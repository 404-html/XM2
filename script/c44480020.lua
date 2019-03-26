--苍白的命运传承
function c44480020.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--eq
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44480020,0))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,44480020)
	e2:SetCondition(c44480020.eqcon)
	e2:SetTarget(c44480020.eqtg)
	e2:SetOperation(c44480020.eqop)
	c:RegisterEffect(e2)
	--eq1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44480020,1))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,44481020)
	e2:SetCondition(c44480020.eqcon1)
	e2:SetTarget(c44480020.eqtg1)
	e2:SetOperation(c44480020.eqop1)
	c:RegisterEffect(e2)
	--eq2
	local e22=Effect.CreateEffect(c)
	e22:SetDescription(aux.Stringid(44480020,2))
	e22:SetCategory(CATEGORY_EQUIP)
	e22:SetType(EFFECT_TYPE_IGNITION)
	e22:SetRange(LOCATION_SZONE)
	e22:SetCountLimit(1,44481120)
	e22:SetCondition(c44480020.eqcon2)
	e22:SetTarget(c44480020.eqtg2)
	e22:SetOperation(c44480020.eqop2)
	c:RegisterEffect(e22)
	
	
end
function c44480020.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x646) 
	and c:IsType(TYPE_MONSTER)
end
function c44480020.cfilter1(c)
	return c:IsFaceup() and c:IsCode(44480011) 
	and c:IsType(TYPE_MONSTER)
end
function c44480020.cfilter2(c)
	return c:IsFaceup() and c:IsCode(44480007) 
	and c:IsType(TYPE_MONSTER)
end
function c44480020.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44480020.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c44480020.eqcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44480020.cfilter1,tp,LOCATION_MZONE,0,1,nil)
end
function c44480020.eqcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44480020.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end

function c44480020.filter(c)
	return c:IsFaceup() 
end
--eq
function c44480020.eqfilter(c,tp)
	return c:CheckUniqueOnField(tp) and c:IsType(TYPE_SPELL+TYPE_TRAP)
    and c:IsSetCard(0x647)
	and not c:IsForbidden()

end
function c44480020.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c44480020.filter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c44480020.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c44480020.eqfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44480020.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c44480020.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local ec=Duel.SelectMatchingCard(tp,c44480020.eqfilter,tp,LOCATION_HAND+LOCATION_GRAVE,LOCATION_HAND+LOCATION_GRAVE,1,1,nil,tp):GetFirst()
	if ec then
		Duel.Equip(tp,ec,tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c44480020.eqlimit)
		e1:SetLabelObject(tc)
		ec:RegisterEffect(e1)
	end
end
function c44480020.eqlimit(e,c)
	return c==e:GetLabelObject()
end
--eq1
function c44480020.eqfilter1(c,tp)
	return c:CheckUniqueOnField(tp) and c:IsType(TYPE_SPELL+TYPE_TRAP)
    --and c:IsSetCard(0x646)
	and not c:IsForbidden()
	--and c:IsSetCard(0x647)
	and c:IsSetCard(0x648)
end
function c44480020.eqtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c44480020.filter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c44480020.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c44480020.eqfilter1,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44480020.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c44480020.eqop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local ec=Duel.SelectMatchingCard(tp,c44480020.eqfilter1,tp,LOCATION_HAND+LOCATION_GRAVE,LOCATION_HAND+LOCATION_GRAVE,1,1,nil,tp):GetFirst()
	if ec then
		Duel.Equip(tp,ec,tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c44480020.eqlimit)
		e1:SetLabelObject(tc)
		ec:RegisterEffect(e1)
	end
end
function c44480020.eqlimit(e,c)
	return c==e:GetLabelObject()
end
--eq2
function c44480020.eqfilter2(c,tp)
	return c:CheckUniqueOnField(tp) and c:IsType(TYPE_SPELL+TYPE_TRAP)
    --and c:IsSetCard(0x646)
	and not c:IsForbidden()
	--and c:IsSetCard(0x647)
	and c:IsSetCard(0x649)
end
function c44480020.eqtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c44480020.filter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c44480020.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c44480020.eqfilter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44480020.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c44480020.eqop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local ec=Duel.SelectMatchingCard(tp,c44480020.eqfilter2,tp,LOCATION_HAND+LOCATION_GRAVE,LOCATION_HAND+LOCATION_GRAVE,1,1,nil,tp):GetFirst()
	if ec then
		Duel.Equip(tp,ec,tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c44480020.eqlimit2)
		e1:SetLabelObject(tc)
		ec:RegisterEffect(e1)
	end
end
function c44480020.eqlimit2(e,c)
	return c==e:GetLabelObject()
end