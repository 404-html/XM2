--动物伙伴
function c32880024.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN+CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c32880024.cost)
	e1:SetCondition(c32880024.actcon)
	e1:SetTarget(c32880024.target)
	e1:SetOperation(c32880024.activate)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c32880024.lvtg)
	e2:SetOperation(c32880024.lvop)
	c:RegisterEffect(e2)
end
function c32880024.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x755,3,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x755,3,REASON_COST)
end
function c32880024.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x733)
end
function c32880024.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32880024.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32880024.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,32880027,0x730,0x4011,2000,2000,3,RACE_BEAST,ATTRIBUTE_EARTH)
		or Duel.IsPlayerCanSpecialSummonMonster(tp,32880026,0x730,0x4011,1000,2000,3,RACE_BEAST,ATTRIBUTE_EARTH)
		or Duel.IsPlayerCanSpecialSummonMonster(tp,32880025,0x730,0x4011,2000,1000,3,RACE_BEAST,ATTRIBUTE_EARTH)
		and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c32880024.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,32880027,0x730,0x4011,2000,1000,3,RACE_BEAST,ATTRIBUTE_EARTH) 
	   or not Duel.IsPlayerCanSpecialSummonMonster(tp,32880026,0x730,0x4011,1000,2000,3,RACE_BEAST,ATTRIBUTE_EARTH) 
	   or not Duel.IsPlayerCanSpecialSummonMonster(tp,32880025,0x730,0x4011,2000,1000,3,RACE_BEAST,ATTRIBUTE_EARTH) then return end
	local dc=Duel.TossDice(tp,1) 
	local token=Duel.CreateToken(tp,32880027)
	if dc==1 or dc==6 then local token=Duel.CreateToken(tp,32880027) 
	   if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) then 
			  local e1=Effect.CreateEffect(e:GetHandler()) 
			  e1:SetType(EFFECT_TYPE_FIELD)
			  e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
			  e1:SetRange(LOCATION_MZONE)
			  e1:SetTargetRange(0,LOCATION_MZONE)
			  e1:SetCondition(c32880024.atcon)
			  e1:SetValue(c32880024.atlimit)
			  token:RegisterEffect(e1,true)
	   end
	elseif dc==2 or dc==5 then local token=Duel.CreateToken(tp,32880026) 
	   if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) then 
		  local e1=Effect.CreateEffect(e:GetHandler()) 
				e1:SetType(EFFECT_TYPE_FIELD)
				e1:SetCode(EFFECT_UPDATE_ATTACK)
				e1:SetRange(LOCATION_MZONE)
				e1:SetTargetRange(LOCATION_MZONE,0)
				e1:SetTarget(c32880024.tg)
				e1:SetValue(500)
				token:RegisterEffect(e1,true)
	   end
	elseif dc==3 or dc==4 then local token=Duel.CreateToken(tp,32880025) 
	   if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) then 
		  local e1=Effect.CreateEffect(e:GetHandler()) 
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_SPSUMMON_SUCCESS)
				e1:SetOperation(c32880024.sumsuc)
				token:RegisterEffect(e1,true)
	   end
	end
	Duel.SpecialSummonComplete()
end
function c32880024.atcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP)
end
function c32880024.atlimit(e,c)
	return c~=e:GetHandler() 
end
function c32880024.tg(e,c)
	return c:IsSetCard(0x730) and c~=e:GetHandler() and not c:IsSetCard(0x732)
end
function c32880024.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c32880024.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST) and c:GetLevel()>0
end
function c32880024.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c32880024.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c32880024.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET+HINGMSG_LVRANK)
	local lv=Duel.AnnounceLevel(tp,1,8)
	e:SetLabel(lv)
	Duel.SelectTarget(tp,c32880024.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c32880024.lvop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		tc:RegisterEffect(e1)
	end
	Duel.BreakEffect()
	Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,e:GetHandler())
end