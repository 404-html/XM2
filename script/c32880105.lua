--HS英雄 萨满
function c32880105.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,32880105)
	e1:SetCondition(c32880105.spcon)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN+CATEGORY_DICE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,32880132)
	e2:SetCost(c32880105.cost)
	e2:SetTarget(c32880105.target)
	e2:SetOperation(c32880105.operation)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c32880105.drcon)
	e3:SetTarget(c32880105.drtg)
	e3:SetOperation(c32880105.drop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c32880105.spcon(e,tp,eg,ep,ev,re,r,rp)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0,nil)==0
end
function c32880105.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,2,REASON_COST)
end
function c32880105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,32880106,0x730,0x4011,0,1000,1,RACE_PSYCHO,ATTRIBUTE_LIGHT)
		or Duel.IsPlayerCanSpecialSummonMonster(tp,32880107,0x730,0x4011,500,500,1,RACE_PSYCHO,ATTRIBUTE_FIRE)
		or Duel.IsPlayerCanSpecialSummonMonster(tp,32880108,0x730,0x4011,0,1000,1,RACE_PSYCHO,ATTRIBUTE_EARTH)
		and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c32880105.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,32880106,0x730,0x4011,0,1000,1,RACE_PSYCHO,ATTRIBUTE_LIGHT)
	   or not Duel.IsPlayerCanSpecialSummonMonster(tp,32880107,0x730,0x4011,500,500,1,RACE_PSYCHO,ATTRIBUTE_FIRE)
	   or not Duel.IsPlayerCanSpecialSummonMonster(tp,32880108,0x730,0x4011,0,1000,1,RACE_PSYCHO,ATTRIBUTE_EARTH) then return end
	local dc=Duel.TossDice(tp,1) 
	local token=Duel.CreateToken(tp,32880106)
	if dc==1 or dc==6 then local token=Duel.CreateToken(tp,32880106) 
	   if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) then 
		  local e1=Effect.CreateEffect(e:GetHandler()) 
		  e1:SetCategory(CATEGORY_RECOVER)
		  e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
		  e1:SetCode(EVENT_PHASE+PHASE_END)
		  e1:SetRange(LOCATION_MZONE)
		  e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		  e1:SetCountLimit(1)
		  e1:SetCondition(c32880105.reccon)
		  e1:SetTarget(c32880105.rectg)
		  e1:SetOperation(c32880105.recop)
		  token:RegisterEffect(e1,true)
	   end
	elseif dc==2 or dc==5 then local token=Duel.CreateToken(tp,32880107) 
		   Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	elseif dc==3 or dc==4 then local token=Duel.CreateToken(tp,32880108) 
	   if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) then 
		  local e1=Effect.CreateEffect(e:GetHandler()) 
		  e1:SetType(EFFECT_TYPE_FIELD)
		  e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
		  e1:SetRange(LOCATION_MZONE)
		  e1:SetTargetRange(0,LOCATION_MZONE)
		  e1:SetCondition(c32880105.atcon)
		  e1:SetValue(c32880105.atlimit)
		  token:RegisterEffect(e1,true)
	   end
	end
	Duel.SpecialSummonComplete()
end
function c32880105.reccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c32880105.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c32880105.recop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,1000,REASON_EFFECT)
end
function c32880105.atcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP)
end
function c32880105.atlimit(e,c)
	return c~=e:GetHandler() 
end
function c32880105.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x745)
end
function c32880105.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c32880105.filter,1,nil)
end
function c32880105.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c32880105.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end