--冬青龙
function c24560032.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24560032,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,24560032)
	e1:SetCondition(c24560032.spcon1)
	e1:SetTarget(c24560032.sptg1)
	e1:SetOperation(c24560032.spop1)
	c:RegisterEffect(e1)
	--sort
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24560032,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c24560032.sttg)
	e2:SetOperation(c24560032.stop)
	c:RegisterEffect(e2)
end
function c24560032.sttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ggc=Duel.GetMatchingGroupCount(c24560032.fil2,tp,LOCATION_GRAVE,0,nil)
	if ggc>12 then ggb=12
	else ggb=ggc
	end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if ct>=ggb or ct2>=ggb then return true end
	if chk==0 then return true end
end
function c24560032.stop(e,tp,eg,ep,ev,re,r,rp)
	local ggc=Duel.GetMatchingGroupCount(c24560032.fil2,tp,LOCATION_GRAVE,0,nil)
	if ggc>12 then ggb=12
	else ggb=ggc
	end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if ct>=ggb and ct2>=ggb then
		local paly=Duel.SelectOption(tp,aux.Stringid(24560032,2),aux.Stringid(24560032,3))
		if paly==0 then
			Duel.SortDecktop(tp,tp,ggb)
		elseif paly==1 then
			Duel.SortDecktop(tp,1-tp,ggb)
		end
	elseif ct>=ggb and ct2<ggb then
		Duel.SortDecktop(tp,tp,ggc)
	elseif ct<ggb and ct2>=ggb then
		Duel.SortDecktop(tp,1-tp,ggb)
	end
end
function c24560032.fil2(c)
	return c:IsRace(RACE_DRAGON+RACE_PLANT) and c:IsType(TYPE_MONSTER) and c:GetPreviousLocation()==LOCATION_DECK 
end
function c24560032.fil1(c)
	return c:IsRace(RACE_DRAGON+RACE_PLANT) and c:IsType(TYPE_TUNER) and c:GetPreviousLocation()==LOCATION_DECK 
end
function c24560032.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c24560032.fil1,tp,LOCATION_GRAVE,0,3,nil)
end
function c24560032.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c24560032.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end