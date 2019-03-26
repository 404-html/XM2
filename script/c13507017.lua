local m=13507017
local tg={13507001}
local cm=_G["c"..m]
cm.name="圆环海盗 艾乌库蕾雅"
function cm.initial_effect(c)
	c:SetSPSummonOnce(m)
	--Special Summon Proc
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCondition(cm.sppcon)
	e1:SetOperation(cm.sppop)
	c:RegisterEffect(e1)
end
cm.card_code_list={tg[1]}
--Special Summon Proc
function cm.sppfilter(c,tp)
	return c:IsFaceup() and aux.IsCodeListed(c,tg[1]) and c:IsAbleToRemoveAsCost()
		and Duel.GetMZoneCount(tp,c)>0
end
function cm.sppcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(cm.sppfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function cm.sppop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,cm.sppfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end