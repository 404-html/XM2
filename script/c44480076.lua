--蓝瞳器·哀伤细剑
function c44480076.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44480076,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,44480076+EFFECT_COUNT_CODE_OATH)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c44480076.cttg)
	e1:SetOperation(c44480076.ctactivate)
	c:RegisterEffect(e1)
	--atk
	local e20=Effect.CreateEffect(c)
	e20:SetType(EFFECT_TYPE_EQUIP)
	e20:SetCode(EFFECT_UPDATE_ATTACK)
	e20:SetValue(-500)
	c:RegisterEffect(e20)
	--Double Attack
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_EQUIP)
	e21:SetCode(EFFECT_EXTRA_ATTACK)
	e21:SetValue(1)
	c:RegisterEffect(e21)
	--disable
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_EQUIP)
	e22:SetCode(EFFECT_DISABLE)
	--e22:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e22)
end
function c44480076.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetChainLimit(aux.FALSE)
end
function c44480076.ctactivate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
