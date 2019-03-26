--星光元素法师 莱娜
if not pcall(function() require("expansions/script/c10199990") end) then require("script/c10199990") end
local m=17500015
local cm=_G["c"..m]
function cm.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_SPELLCASTER),2)
	local e1=rsef.STO(c,EVENT_SPSUMMON_SUCCESS,{m,0},{1,m},"se,th",nil,nil,nil,cm.tg,cm.op)
	local e2=rsef.I(c,{m,1},{1,m+1},"atk,def,dis",EFFECT_FLAG_NO_TURN_RESET,LOCATION_MZONE,nil,nil,cm.tg2,cm.op2)
end
cm.setname="ElementalWizard"
function cm.atkfilter(c)
	return c:IsFaceup() and (c:IsAttackAbove(0) or c:IsDefenseAbove(0) or aux.disfilter1(c))
end
function cm.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.atkfilter,tp,0,LOCATION_MZONE,1,nil) end
end
function cm.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc=Duel.SelectMatchingCard(tp,cm.atkfilter,tp,0,LOCATION_MZONE,1,1,nil):GetFirst()
	if tc then
		local e1,e2=rsef.SV_SET({c,tc},"atkf,deff",0,nil,rsreset.est)
		local e3=rsef.SV_LIMIT({c,tc},"dis",0,nil,rsreset.est)
	end
end
function cm.filter1(c)
	return c.setname=="ElementalSpell" and c:IsAbleToHand()
end
function cm.filter2(c)
	return c.setname=="ElementalWizard" and c:IsAbleToHand()
end
function cm.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cm.filter1,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(cm.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK)
end
function cm.op(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(cm.filter1,tp,LOCATION_DECK,0,nil)
	local g2=Duel.GetMatchingGroup(cm.filter2,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg2=g2:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		Duel.SendtoHand(sg1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg1)
	end
end
