--☯红魔馆的女仆队☯
function c60002.initial_effect(c)
	--summon with 1 tribute
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(60002,0))
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SUMMON_PROC)
	e0:SetCondition(c60002.otcon)
	e0:SetOperation(c60002.otop)
	e0:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e0)		
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60002,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,60002)
	e1:SetCost(c60002.negcost)
	e1:SetTarget(c60002.tgtg)
	e1:SetOperation(c60002.tgop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--spsummon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(60002,3))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetCondition(c60002.spcon)
	e6:SetTarget(c60002.sptg)
	e6:SetOperation(c60002.spop)
	c:RegisterEffect(e6)
end
            -- if (ActivateDescription == AI.Utils.GetStringId(_CardId.CastelTheSkyblasterMusketeer, 1))
            -- {
                -- AI.SelectCard(CardId.RDFlandre);
                -- return true;
            -- }
function c60002.otcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.CheckTribute(c,1)
end
function c60002.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.SelectTribute(tp,c,1,1)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c60002.filter(c,e,tp,eg,ep,ev,re,r,rp)
	local cod2={
		[1] = {60700,c60700},
		[2] = {1230900,c1230900},
		[3] = {1231100,c1231100},
		[4] = {1231300,c1231300},
	}
	for i=1,4 do
		if c:GetOriginalCode()==cod2[i][1] and c:IsSetCard(0x813) and cod2[i][2].distarget then 
			return cod2[i][2].distarget(e,tp,eg,ep,ev,re,r,rp,0,false) and c:IsSetCard(0x813) and c:IsAbleToGraveAsCost()
		end 
	end 
	return false
end
function c60002.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60002.filter,tp,LOCATION_DECK,0,1,nil,e,tp,eg,ep,ev,re,r,rp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cc=Duel.SelectMatchingCard(tp,c60002.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(cc,REASON_COST)
	e:SetLabelObject(cc)
	cc:KeepAlive()
end
function c60002.cosfilter(c,e,tp,eg,ep,ev,re,r,rp,chkc)
	local cod2={
		[1] = {60700,c60700},
		[2] = {1230900,c1230900},
		[3] = {1231100,c1231100},
		[4] = {1231300,c1231300},
	}
	for i=1,4 do
		if c:GetOriginalCode()==cod2[i][1] and c:IsSetCard(0x813) and cod2[i][2].distarget then 
			return cod2[i][2].distarget(e,tp,eg,ep,ev,re,r,rp,0,false)
		end 
	end 
	return false 
end
function c60002.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local rg=Duel.GetMatchingGroup(c60002.cosfilter,tp,LOCATION_DECK,0,nil,e,tp,eg,ep,ev,re,r,rp)
	if rg:GetCount()<=0 then return end 
	if chkc then
		local rg=Duel.GetMatchingGroup(c60002.cosfilter,tp,LOCATION_DECK,0,nil,e,tp,eg,ep,ev,re,r,rp)
		return rg:GetCount()>0 
	end
	if chk==0 then return true end
	local cod2={
		[1] = {60700,c60700},
		[2] = {1230900,c1230900},
		[3] = {1231100,c1231100},
		[4] = {1231300,c1231300},
	}	local ac=e:GetLabelObject():GetFirst()
	for i=1,4 do
		if ac:GetOriginalCode()==cod2[i][1] and ac:IsSetCard(0x813) then 
				cod2[i][2].distarget(e,tp,eg,ep,ev,re,r,rp,1)
		end 
	end 
end
function c60002.tgop(e,tp,eg,ep,ev,re,r,rp)
	local cod2={
		[1] = {60700,c60700},
		[2] = {1230900,c1230900},
		[3] = {1231100,c1231100},
		[4] = {1231300,c1231300},
	}
	local ac=e:GetLabelObject():GetFirst()
	if not ac then return end
	for i=1,4 do
		if ac:GetOriginalCode()==cod2[i][1] and ac:IsSetCard(0x813) then 
				cod2[i][2].disop(e,tp,eg,ep,ev,re,r,rp,1)
		end 
	end 
end
function c60002.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(c:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE and c:IsPreviousLocation(LOCATION_MZONE) and c:IsLocation(LOCATION_GRAVE)
end
function c60002.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	local lv=Duel.AnnounceLevel(tp,1,9)
	e:SetLabel(lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60002.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		--xyzsummmon
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(60002,3))
		e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e2:SetType(EFFECT_TYPE_QUICK_O)
		e2:SetCode(EVENT_FREE_CHAIN)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e2:SetHintTiming(0,TIMING_STANDBY_PHASE+TIMING_DRAW_PHASE+TIMING_SUMMON+TIMING_END_PHASE)
		e2:SetCondition(c60002.sccon)
		e2:SetTarget(c60002.sptg2)
		e2:SetOperation(c60002.spop2)
		c:RegisterEffect(e2)
	end
end
function c60002.sccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c60002.sccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c60002.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_MZONE,0,nil,0x813)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsXyzSummonable,tp,LOCATION_EXTRA,0,1,nil,mg) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c60002.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local mg=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_MZONE,0,nil,0x813)
	if c:IsControler(1-tp) or not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(Card.IsXyzSummonable,tp,LOCATION_EXTRA,0,nil,mg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.XyzSummon(tp,sg:GetFirst(),mg,1,mg:GetCount())
	end
end