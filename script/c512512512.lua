--玄化渊眼龙
if not pcall(function() require("expansions/script/c10199990") end) then require("script/c10199990") end
local m=512512512
local cm=_G["c"..m]
function cm.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	local e1=rsef.FTO(c,EVENT_DAMAGE_STEP_END,{m,0},2,"des",nil,LOCATION_PZONE,cm.descon,nil,cm.destg,cm.desop)
	local e2=rsef.STO(c,EVENT_SPSUMMON_SUCCESS,{m,1},nil,"dam","de,ptg",cm.damcon,nil,cm.damtg,cm.damop)
	local e3=rsef.STO(c,EVENT_SPSUMMON_SUCCESS,{m,2},nil,"atk","de,tg",nil,nil,rstg.target(rscf.FilterFaceUp(Card.IsRace,RACE_WYRM),nil,LOCATION_REMOVED),cm.atkop)
	local e4=rsef.RegisterClone(c,e3,"code",EVENT_SUMMON_SUCCESS)
	local e5=rsef.FTO(c,EVENT_PHASE+PHASE_STANDBY,{m,0},1,"des,sp",nil,LOCATION_REMOVED,cm.spcon,rscost.costself(Card.IsAbleToDeckAsCost,"td"),cm.sptg,cm.spop)
end
function cm.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==e:GetHandler():GetTurnID()+1
end
function cm.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(cm.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,0,0,LOCATION_REMOVED)
end
function cm.spfilter(c,e,tp)
	return c:IsRace(RACE_WYRM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,cm.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if #g>0 then
		Duel.HintSelection(g)
		if Duel.Destroy(g,REASON_EFFECT)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp) and Duel.SelectYesNo(tp,aux.Stringid(m,3)) then
			rsof.SelectHint(tp,"sp")
			local sg=Duel.SelectMatchingCard(tp,cm.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
			rssf.SpecialSummon(sg)
		end
	end
end
function cm.atkop(e,tp)
	local c,tc=rscf.GetRelationThisCard(e),rscf.GetTargetCard()
	if not c or not tc then return end
	local atk=tc:GetAttack()
	local e1=rsef.SV_SET(c,"atkf",atk*2,nil,rsreset.est_d)
end
function cm.damcon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0x105)
end
function cm.damfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_WYRM)
end
function cm.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.damfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) end
	local val=Duel.GetMatchingGroupCount(cm.damfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)*600
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(val)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,val)
end
function cm.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local val=Duel.GetMatchingGroupCount(cm.damfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)*600
	Duel.Damage(p,val,REASON_EFFECT)
end
function cm.descon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(tp) and at:IsSetCard(0x105) 
end
function cm.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function cm.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(cm.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function cm.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,cm.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if #g>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end