--猛毒性 DOGARS
function c24562457.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCondition(c24562457.e1con)
	e1:SetTarget(c24562457.e1tg)
	e1:SetOperation(c24562457.e1op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24562457,0))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(aux.exccon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c24562457.e2tg)
	e2:SetOperation(c24562457.e2op)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24562457,1))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCondition(aux.exccon)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c24562457.e3tg)
	e3:SetOperation(c24562457.e3op)
	c:RegisterEffect(e3)
end
function c24562457.e1con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c24562457.e1fil(c,e,tp)
	return c:IsSetCard(0x1390) and 
	c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c24562457.e1tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c24562457.e1fil,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c24562457.e1op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c24562457.e1fil,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c24562457.e2tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c24562457.e2fil,tp,LOCATION_HAND,0,1,nil) or Duel.GetLocationCount(tp,LOCATION_MZONE)==0 and Duel.IsExistingMatchingCard(c24562457.e2fil2,tp,LOCATION_HAND,0,1,nil,e)) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c24562457.e2fil(c)
	return c:IsType(TYPE_DUAL) and c:IsSummonable(true,nil) 
end
function c24562457.e2fil2(c,e)
	local tp=e:GetHandler():GetControler()
	return c:IsType(TYPE_DUAL) and c:IsSummonable(true,nil) and c:IsLevelAbove(5) and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
end
function c24562457.e2op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
		local g=Duel.SelectMatchingCard(tp,c24562457.e2fil,tp,LOCATION_HAND,0,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			if Duel.Summon(tp,tc,true,nil)~=0 then 
				tc:EnableDualState()
			end
		end
	elseif Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local g=Duel.SelectMatchingCard(tp,c24562457.e2fil2,tp,LOCATION_HAND,0,1,1,nil,e)
			local tc=g:GetFirst()
			if tc then
				if Duel.Summon(tp,tc,true,nil)~=0 then 
					tc:EnableDualState()
				end
			end
		end
	end
end
function c24562457.e3fil(c)
	return c:IsFaceup() 
	 and c:IsType(TYPE_DUAL) 
	  and not c:IsDualState()
end
function c24562457.e3op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c24562457.e3fil,tp,LOCATION_MZONE,0,1,nil) then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c24562457.e3fil,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	  if tc then
		tc:EnableDualState()
	  end
	end
end
function c24562457.e3tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c24562457.e3fil(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c24562457.e3fil,tp,LOCATION_MZONE,0,1,nil,e,tp) end
end