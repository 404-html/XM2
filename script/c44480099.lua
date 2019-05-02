--蓝瞳器·永恒之枪
function c44480099.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c44480099.target)
	e1:SetOperation(c44480099.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c44480099.eqlimit)
	c:RegisterEffect(e2)

	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e6=e3:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e6)
	local e7=e3:Clone()
	e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e7)
	local e16=e3:Clone()
	e16:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	c:RegisterEffect(e16)
	--equip effect
	local e17=Effect.CreateEffect(c)
	e17:SetType(EFFECT_TYPE_EQUIP)
	e17:SetCode(EFFECT_UPDATE_ATTACK)
	e17:SetValue(1000)
	c:RegisterEffect(e17)
	--disable
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_EQUIP)
	e21:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e21)
	--Destroy
	local e22=Effect.CreateEffect(c)
	e22:SetCategory(CATEGORY_TOGRAVE)
	--e22:SetType((EFFECT_TYPE_EQUIP))
	e22:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e22:SetCode(EVENT_ATTACK_ANNOUNCE)
	e22:SetRange(LOCATION_SZONE)
	e22:SetCondition(c44480099.descon)
	e22:SetOperation(c44480099.desop)
	c:RegisterEffect(e22)


end
function c44480099.eqlimit(e,c)
	return c:IsType(TYPE_MONSTER)
end
function c44480099.filter(c)
	return c:IsFaceup() 
end
function c44480099.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c44480099.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44480099.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c44480099.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c44480099.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
--Destroy
function c44480099.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler():GetEquipTarget()
	and not e:GetHandler():GetEquipTarget():IsSetCard(0x646)
end
function c44480099.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.SendtoGrave(tc,nil,REASON_RULE)
	end
end
