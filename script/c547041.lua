--AL 试作型布里MKⅡ
function c547041.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,3)
	c:EnableReviveLimit()	
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(547041,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c547041.target)
	e2:SetOperation(c547041.activate)
	c:RegisterEffect(e2)
	--xyz level
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(547041,2))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetTarget(c547041.xyztg)
	e3:SetOperation(c547041.xyzop)
	c:RegisterEffect(e3)
	--remove overlay replace
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(547041,3))
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c547041.rcon)
	e4:SetOperation(c547041.rop)
	c:RegisterEffect(e4)
end
function c547041.filter(c,e,tp)
	return c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c547041.xyzfilter(c,mg)
	return  c:IsXyzSummonable(mg,1,3)
end
function c547041.xyzfilter2(c,mg,count1,count2)
	return  c:IsXyzSummonable(mg,count1,count2)
end
function c547041.mfilter1(c,g,exg)
	return g:IsExists(c547041.mfilter4,1,c,c,exg) or exg:IsExists(Card.IsXyzSummonable,1,nil,Group.FromCards(c),1,1)
end
function c547041.mfilter2(c,mc,exg)
	return exg:IsExists(Card.IsXyzSummonable,1,nil,Group.FromCards(c,mc),2,3)
end
function c547041.mfilter3(c,mc1,mc2,exg)
	return exg:IsExists(Card.IsXyzSummonable,1,nil,Group.FromCards(c,mc1,mc2),3,3)
end
function c547041.mfilter4(c,mc1,exg)
	return exg:IsExists(Card.IsXyzSummonable,1,nil,Group.FromCards(c,mc1),2,3) 
end
function c547041.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local zone=c:GetLinkedZone(tp)
	if chkc then return false end
	local mg=Duel.GetMatchingGroup(c547041.filter,tp,LOCATION_GRAVE,0,nil,e,tp)
	local exg=Group.CreateGroup()
	local count3=math.max(Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone),2)
	exg=Duel.GetMatchingGroup(c547041.xyzfilter2,tp,LOCATION_EXTRA,0,nil,mg,2,count3)
	if Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)<1 then 
		exg=Duel.GetMatchingGroup(c547041.xyzfilter2,tp,LOCATION_EXTRA,0,nil,mg,1,1)
	end 
	local exg2=Duel.GetMatchingGroup(c547041.xyzfilter2,tp,LOCATION_EXTRA,0,nil,mg,1,1)
	exg:Merge(exg2)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,1) and Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
		and mg:GetCount()>0 and Duel.GetLocationCountFromEx(tp)>0
		and exg:GetCount()>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg1=mg:FilterSelect(tp,c547041.mfilter1,1,1,nil,mg,exg)
	local tc1=sg1:GetFirst()
	if tc1 and exg:IsExists(Card.IsXyzSummonable,1,nil,sg1,1,1) 
		and ((not Duel.IsPlayerCanSpecialSummonCount(tp,2)) or (not exg:IsExists(Card.IsXyzSummonable,1,nil,mg,2,3)) or Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)==1 or Duel.SelectYesNo(tp,aux.Stringid(547041,4))) then 
		Duel.SetTargetCard(sg1)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg1,sg1:GetCount(),0,0)
	elseif tc1 and Duel.IsPlayerCanSpecialSummonCount(tp,2) then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=mg:FilterSelect(tp,c547041.mfilter2,1,1,tc1,tc1,exg)
		local tc2=sg2:GetFirst()
		sg1:Merge(sg2)
		if mg:GetCount()>2 and mg:IsExists(c547041.mfilter3,1,nil,tc1,tc2,exg) and Duel.IsPlayerCanSpecialSummonCount(tp,3) and Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>2 and (exg2:GetCount()==0 or Duel.SelectYesNo(tp,aux.Stringid(547041,1))) then 	
			local sg3=mg:FilterSelect(tp,c547041.mfilter3,1,1,tc1,tc1,tc2,exg)
			sg1:Merge(sg3)		
		end 
		Duel.SetTargetCard(sg1)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg1,2,0,0)
	end 
end
function c547041.filter2(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c547041.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local zone=c:GetLinkedZone(tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)<1 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c547041.filter2,nil,e,tp)
	if g:GetCount()<1 then return end
	local pay_group=Group.CreateGroup()
	local tc=g:Select(tp,1,1,pay_group)
	pay_group:Merge(tc)
	local i=1
	while tc and tc:GetCount()>0 and Duel.IsPlayerCanSpecialSummonCount(tp,i) and Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0 do
		Duel.SpecialSummonStep(tc:GetFirst(),0,tp,tp,false,false,POS_FACEUP,zone)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:GetFirst():RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		tc:GetFirst():RegisterEffect(e2)
		tc=g:Select(tp,1,1,pay_group)
		pay_group:Merge(tc)
		i=i+1
	end
	Duel.SpecialSummonComplete()
	local xyzg=Duel.GetMatchingGroup(c547041.xyzfilter2,tp,LOCATION_EXTRA,0,nil,g,g:GetCount(),g:GetCount())
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.XyzSummon(tp,xyz,g,g:GetCount(),g:GetCount())
	end
end
function c547041.xyzfilter22(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c547041.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c547041.xyzfilter22(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c547041.xyzfilter22,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c547041.xyzfilter22,tp,LOCATION_MZONE,0,1,1,nil)
end
function c547041.xyzop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_LEVEL)
		e1:SetValue(tc:GetRank())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e:GetHandler():RegisterEffect(e1)
	end
end
function c547041.rrfilter(c)
	return c:IsSetCard(0x212)
end
function c547041.rcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(5470411+ep)==0
		and bit.band(r,REASON_COST)~=0 and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_XYZ)
		and re:GetHandler():GetOverlayCount()>=ev-1 and re:GetHandler():IsSetCard(0xa12)
		and Duel.IsExistingMatchingCard(c547041.rrfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c547041.rop(e,tp,eg,ep,ev,re,r,rp)
	local ct=bit.band(ev,0xffff)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c547041.rrfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	if ct>1 then
		re:GetHandler():RemoveOverlayCard(tp,ct-1,ct-1,REASON_COST)
	end
	e:GetHandler():RegisterFlagEffect(5470411+ep,RESET_PHASE+PHASE_END,0,1)
end