--HS野兽 温顺的巨壳龙
function c32880241.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c32880241.spcon)
	e1:SetOperation(c32880241.spop)
	c:RegisterEffect(e1)
	--random
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DICE+CATEGORY_ATKCHANGE+CATEGORY_DESTROY+CATEGORY_COIN+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetTarget(c32880241.target)
	e2:SetOperation(c32880241.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3) 
end
function c32880241.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsCanRemoveCounter(tp,1,0,0x755,4,REASON_COST)
end
function c32880241.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.RemoveCounter(tp,1,0,0x755,4,REASON_COST)
end
function c32880241.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c32880241.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x735)
end
c32880241.toss_coin=true
function c32880241.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local dc=Duel.TossDice(tp,1) 
	local c1=Duel.TossCoin(tp,1)
	while dc==5 or dc==6 do
		  dc=Duel.TossDice(tp,1)
	end
	if dc==1 then 
	   if c1==1 then 
		  local g=Duel.GetMatchingGroup(c32880241.filter,tp,LOCATION_MZONE,0,nil)
		  local tc=g:GetFirst()
		  while tc do 
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetCategory(CATEGORY_TOKEN+CATEGORY_SPECIAL_SUMMON)
				e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
				e1:SetProperty(EFFECT_FLAG_DELAY)
				e1:SetCode(EVENT_TO_GRAVE)
				e1:SetCondition(c32880241.spcon2)
				e1:SetTarget(c32880241.sptg2)
				e1:SetOperation(c32880241.spop2)
				tc:RegisterEffect(e1)
				tc=g:GetNext()
		  end
	   elseif c1==0 then 
			  local g=Duel.GetMatchingGroup(c32880241.filter,tp,LOCATION_MZONE,0,nil)
			  local tc=g:GetFirst()
			  local preatk=tc:GetAttack()
			  while tc do 
					local preatk=tc:GetAttack()
					local e1=Effect.CreateEffect(e:GetHandler())
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetCode(EFFECT_UPDATE_ATTACK)
					e1:SetReset(RESET_EVENT+0x1fe0000)
					e1:SetValue(1500)
					tc:RegisterEffect(e1)
					tc=g:GetNext()
			  end 
	   end
	elseif dc==2 then 
		   if c1==1 then 
			  local g=Duel.GetMatchingGroup(c32880241.filter,tp,LOCATION_MZONE,0,nil)
			  local tc=g:GetFirst()
			  while tc do 
					local e1=Effect.CreateEffect(e:GetHandler())
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
					e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
					e1:SetRange(LOCATION_MZONE)
					e1:SetValue(1)
					tc:RegisterEffect(e1)
					tc=g:GetNext()
			  end
		   elseif c1==0 then 
				  local g=Duel.GetMatchingGroup(c32880241.filter,tp,LOCATION_MZONE,0,nil)
				  local tc=g:GetFirst()
				  while tc do 
						local e1=Effect.CreateEffect(e:GetHandler())
						e1:SetType(EFFECT_TYPE_FIELD)
						e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
						e1:SetRange(LOCATION_MZONE)
						e1:SetTargetRange(0,LOCATION_MZONE)
						e1:SetCondition(c32880241.atcon)
						e1:SetValue(c32880241.atlimit)
						tc:RegisterEffect(e1)
						tc=g:GetNext()
				  end
		   end
	elseif dc==3 then 
		   if c1==1 then 
			  local g=Duel.GetMatchingGroup(c32880241.filter,tp,LOCATION_MZONE,0,nil)
			  local tc=g:GetFirst()
			  while tc do 
					local e1=Effect.CreateEffect(e:GetHandler())
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetCode(EFFECT_EXTRA_ATTACK)
					e1:SetValue(1)
					tc:RegisterEffect(e1)
					tc=g:GetNext()
			  end 
		   elseif c1==0 then 
				  local g=Duel.GetMatchingGroup(c32880241.filter,tp,LOCATION_MZONE,0,nil)
				  local tc=g:GetFirst()
				  while tc do 
						local e1=Effect.CreateEffect(e:GetHandler())
						e1:SetType(EFFECT_TYPE_SINGLE)
						e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_NO_TURN_RESET)
						e1:SetRange(LOCATION_MZONE)
						e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
						e1:SetCountLimit(1)
						e1:SetValue(c32880241.valcon)
						tc:RegisterEffect(e1)
						tc=g:GetNext()
				  end
		   end 
	elseif dc==4 then 
		   if c1==1 then 
			  local g=Duel.GetMatchingGroup(c32880241.filter,tp,LOCATION_MZONE,0,nil)
			  local tc=g:GetFirst()
			  while tc do 
					local e1=Effect.CreateEffect(e:GetHandler())
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
					e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
					e1:SetRange(LOCATION_MZONE)
					e1:SetValue(aux.imval1)
					tc:RegisterEffect(e1)
					local e2=e1:Clone()
					e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
					e2:SetValue(aux.tgoval)
					tc:RegisterEffect(e2)
					tc=g:GetNext()
			  end 
		   elseif c1==0 then 
				  local g=Duel.GetMatchingGroup(c32880241.filter,tp,LOCATION_MZONE,0,nil)
				  local tc=g:GetFirst()
				  while tc do 
						local e1=Effect.CreateEffect(e:GetHandler())
						e1:SetCategory(CATEGORY_DESTROY)
						e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
						e1:SetCode(EVENT_BATTLE_CONFIRM)
						e1:SetTarget(c32880241.destg)
						e1:SetOperation(c32880241.desop)
						tc:RegisterEffect(e1)
						tc=g:GetNext()
				  end
		   end					 
	end
end
function c32880241.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) 
end
function c32880241.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
	   and Duel.IsPlayerCanSpecialSummonMonster(tp,32880242,0x730,0x4011,500,500,1,RACE_PLANT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c32880241.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,32880242,0x730,0x4011,500,500,1,RACE_PLANT,ATTRIBUTE_EARTH) then
			local token=Duel.CreateToken(tp,32880242)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
function c32880241.atcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP)
end
function c32880241.atlimit(e,c)
	return c~=e:GetHandler() 
end
function c32880241.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c32880241.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local t=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler() and t~=nil end
	Duel.SetTargetCard(t)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,t,1,0,0)
end
function c32880241.desop(e,tp,eg,ep,ev,re,r,rp)
	local t=Duel.GetFirstTarget()
	if t:IsRelateToBattle() then
		Duel.Destroy(t,REASON_EFFECT)
	end
end