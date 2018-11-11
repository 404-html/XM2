--HS 精灵弓箭手
function c32880016.initial_effect(c)
	--damage/Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c32880016.target)
	e1:SetOperation(c32880016.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_HAND)
	e4:SetCondition(c32880016.spcon)
	e4:SetOperation(c32880016.spop)
	c:RegisterEffect(e4)
end
function c32880016.filter(c)
	return c:IsPosition(POS_FACEUP)
end
function c32880016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	local op=Duel.SelectOption(tp,aux.Stringid(32880016,0),aux.Stringid(32880016,1))
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
		Duel.IsExistingTarget(c32880016.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		Duel.SelectTarget(tp,c32880016.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	else
		e:SetCategory(CATEGORY_DAMAGE)
		Duel.SetTargetPlayer(1-tp)
		Duel.SetTargetParam(500)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
	end
end
function c32880016.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local dg=Group.CreateGroup()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if e:GetLabel()==0 then
	   if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		  local preatk=tc:GetAttack()
		  local predef=tc:GetDefense()
		  local e1=Effect.CreateEffect(c)
		  e1:SetType(EFFECT_TYPE_SINGLE)
		  e1:SetCode(EFFECT_UPDATE_ATTACK)
		  e1:SetReset(RESET_EVENT+0x1fe0000)
		  e1:SetValue(-500)
		  tc:RegisterEffect(e1)
		  local e2=Effect.CreateEffect(c)
		  e2:SetType(EFFECT_TYPE_SINGLE)
		  e2:SetCode(EFFECT_UPDATE_DEFENSE)
		  e2:SetReset(RESET_EVENT+0x1fe0000)
		  e2:SetValue(-500)
		  tc:RegisterEffect(e2)
		  if (preatk==0 or tc:GetAttack()==0) or (predef==0 or tc:GetDefense()==0) then dg:AddCard(tc) end   
	   end
	   Duel.Destroy(dg,REASON_EFFECT)
	else Duel.Damage(p,d,REASON_EFFECT) end
end
function c32880016.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsCanRemoveCounter(tp,1,0,0x755,1,REASON_COST)
end
function c32880016.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.RemoveCounter(tp,1,0,0x755,1,REASON_COST)
end