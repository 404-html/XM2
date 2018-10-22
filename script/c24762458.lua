--猛毒性 毒丝
function c24762458.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,24762456,aux.FilterBoolFunction(Card.IsRace,RACE_INSECT),1,false,false)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c24762458.splimit)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,24762458)
	e1:SetTarget(c24762458.e1tg)
	e1:SetOperation(c24762458.e1op)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(24762458,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c24762458.e2target)
	e3:SetOperation(c24762458.e2operation)
	c:RegisterEffect(e3)
end
function c24762458.e2target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0 and Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c24762458.e2operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(1-tp,LOCATION_SZONE)<=0 or not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsSetCard(0x1390) then
		if Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0
				and Duel.SelectYesNo(tp,aux.Stringid(24762458,1)) then
				Duel.MoveToField(tc,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
				local e10=Effect.CreateEffect(c)
				e10:SetCode(EFFECT_CHANGE_TYPE)
				e10:SetType(EFFECT_TYPE_SINGLE)
				e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e10:SetReset(RESET_EVENT+0x1fc0000)
				e10:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
				tc:RegisterEffect(e10)
				Duel.RaiseEvent(tc,EVENT_CUSTOM+47408488,e,0,tp,0,0)
	tc:RegisterFlagEffect(24762458,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(24762458,3))
				  local e8=Effect.CreateEffect(c)
				  e8:SetDescription(aux.Stringid(24762458,2))
				  e8:SetProperty(EFFECT_FLAG_CLIENT_HINT)
				  e8:SetType(EFFECT_TYPE_FIELD)
				  e8:SetCode(EFFECT_CANNOT_ATTACK)
				  e8:SetRange(LOCATION_ONFIELD)
				  e8:SetReset(RESET_EVENT+0x1fe0000)
				  e8:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
				  e8:SetTarget(c24762458.atktarget)
				  tc:RegisterEffect(e8,true)
		end
		else
		   if Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)~=0 and tc:IsLocation(LOCATION_GRAVE) then Duel.Damage(1-tp,700,REASON_EFFECT) end
	end
	Duel.ShuffleHand(tp)
end
function c24762458.atktarget(e,c)
	local gp=e:GetHandler():GetControler()
	local g=e:GetHandler():GetColumnGroup()
	return c:IsControler(gp) and g:IsContains(c)
end
function c24762458.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION or se:GetHandler():IsCode(24562458)
end
function c24762458.filter0(c)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial() and c:IsAbleToRemove()
end
function c24762458.filter1(c,e)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial() and c:IsAbleToRemove() and not c:IsImmuneToEffect(e)
end
function c24762458.filter2(c,e,tp,m,f,gc,chkf)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x1390) and (not f or f(c)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,gc,chkf)
end
function c24762458.e1tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local chkf=tp
		local mg1=Duel.GetMatchingGroup(c24762458.filter0,tp,LOCATION_GRAVE,0,nil)
		local res=Duel.GetLocationCountFromEx(tp)>0
			and Duel.IsExistingMatchingCard(c24762458.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,c,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c24762458.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,c,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c24762458.e1op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local chkf=tp
	if not c:IsRelateToEffect(e) or c:IsImmuneToEffect(e) then return end
	local mg1=Duel.GetMatchingGroup(c24762458.filter1,tp,LOCATION_GRAVE,0,nil,e)
	local sg1=Duel.GetMatchingGroup(c24762458.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,c,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c24762458.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,c,chkf)
	end
	if (Duel.GetLocationCountFromEx(tp)>0 and sg1:GetCount()>0) or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,c,chkf)
			tc:SetMaterial(mat1)
			Duel.Remove(mat1,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,c,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end