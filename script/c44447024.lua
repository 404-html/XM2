--百夜·啖梦天使
function c44447024.initial_effect(c)
	c:EnableReviveLimit()
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--Activate same effect
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_ACTIVATE+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c44447024.cost)
	e2:SetTarget(c44447024.target)
	e2:SetOperation(c44447024.activate)
	c:RegisterEffect(e2)
	--desu1
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44447024,1))
	e11:SetHintTiming(0,TIMING_DRAW_PHASE)
	e11:SetCountLimit(1,44447024)
	e11:SetType(EFFECT_TYPE_QUICK_O)
	e11:SetCode(EVENT_FREE_CHAIN)
	e11:SetRange(LOCATION_HAND)
	e11:SetCost(c44447024.acost)
	e11:SetOperation(c44447024.operation)
	c:RegisterEffect(e11)
	--desu2
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(44447024,2))
	e12:SetHintTiming(0,TIMING_DRAW_PHASE)
	e12:SetCountLimit(1,44447024)
	e12:SetType(EFFECT_TYPE_QUICK_O)
	e12:SetCode(EVENT_FREE_CHAIN)
	e12:SetRange(LOCATION_ONFIELD)
	e12:SetCost(c44447024.bcost)
	e12:SetOperation(c44447024.operation)
	c:RegisterEffect(e12)
end
function c44447024.costfilter(c)
	return c:IsAbleToGraveAsCost() and not c:IsCode(44447024)
end
function c44447024.acost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and 
		Duel.IsExistingMatchingCard(c44447024.costfilter,tp,LOCATION_HAND,0,2,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44447024.costfilter,tp,LOCATION_HAND,0,2,2,c)
	g:AddCard(c)
	Duel.SendtoGrave(g,REASON_COST)
end
function c44447024.bcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c44447024.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTarget(c44447024.target)
	e1:SetTargetRange(1,1)
	e1:SetValue(c44447024.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	--cannot attack
	local e11=Effect.CreateEffect(e:GetHandler())
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e11:SetCode(EFFECT_CANNOT_ATTACK)
	e11:SetTargetRange(1,1)
	e11:SetValue(c44447024.aclimit1)
	e11:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e11,tp)
end
function c44447024.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():GetAttack()>2000 
end
function c44447024.aclimit1(e,re,tp)
	return re:GetHandler():GetAttack()>2000 
end
--Activate same effect
function c44447024.cfilter(c)
	return c:GetOriginalCode()==44446024 and c:IsAbleToGraveAsCost()
end
function c44447024.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44447024.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44447024.cfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c44447024.filter(c,e,tp,m,ft)
	if not c:IsSetCard(0x644) or bit.band(c:GetType(),0x81)~=0x81
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
	local mg=m:Filter(Card.IsCanBeRitualMaterial,c,c)
	if c:IsCode(44447000) then return c:ritual_custom_condition(mg,ft) end
	if c.mat_filter then
		mg=mg:Filter(c.mat_filter,nil)
	end
	if ft>0 then
		return mg:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,99,c)
	else
		return ft>-1 and mg:IsExists(c44447024.mfilterf,1,nil,tp,mg,c)
	end
end
function c44447024.mfilterf(c,tp,mg,rc)
	if c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5 then
		Duel.SetSelectedCard(c)
		return mg:CheckWithSumEqual(Card.GetRitualLevel,rc:GetLevel(),0,99,rc)
	else return false end
end
function c44447024.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetRitualMaterial(tp)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		return Duel.IsExistingMatchingCard(c44447024.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp,mg,ft)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c44447024.activate(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetRitualMaterial(tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c44447024.filter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp,mg,ft)
	local tc=tg:GetFirst()
	if tc then
		mg=mg:Filter(Card.IsCanBeRitualMaterial,tc,tc)
		if tc:IsCode(44447000) then
			tc:ritual_custom_operation(mg)
			local mat=tc:GetMaterial()
			Duel.ReleaseRitualMaterial(mat)
		else
			if tc.mat_filter then
				mg=mg:Filter(tc.mat_filter,nil)
			end
			local mat=nil
			if ft>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
				mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),1,99,tc)
			else
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
				mat=mg:FilterSelect(tp,c44447024.mfilterf,1,1,nil,tp,mg,tc)
				Duel.SetSelectedCard(mat)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
				local mat2=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),0,99,tc)
				mat:Merge(mat2)
			end
			tc:SetMaterial(mat)
			Duel.ReleaseRitualMaterial(mat)
		end
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
		local g=Duel.GetOperatedGroup()
		if g:FilterCount(c44447024.sfilter,nil)>0 
	    and Duel.IsExistingMatchingCard(c44447024.efilter,tp,LOCATION_REMOVED,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(44447024,3)) then
			local g=Duel.SelectMatchingCard(tp,c44447024.efilter,tp,LOCATION_REMOVED,0,1,5,nil)
			if g:GetCount()>0 then
                Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		        Duel.ConfirmCards(1-tp,g)	
		        Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		        Duel.ShuffleDeck(tp)
			    Duel.BreakEffect()
			    local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	            if g1:GetCount()>0 then
		        local sg=g1:RandomSelect(1-tp,1)
		        Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
			    end
			end
		end
	end
end
function c44447024.sfilter(c,e,tp)
	return c:IsCode(44447024) and c:IsType(TYPE_MONSTER)
end
function c44447024.efilter(c,e,tp)
	return c:IsSetCard(0x644) and c:IsAbleToDeck() 
end