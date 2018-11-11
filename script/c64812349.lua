--碧蓝工舰-明石
function c64812349.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCountLimit(1,64812449)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c64812349.spcon)
	c:RegisterEffect(e1)
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e4:SetCategory(CATEGORY_POSITION)
	e4:SetCode(EVENT_BE_BATTLE_TARGET)
	e4:SetCountLimit(1,64812349)
	e4:SetCondition(c64812349.negcon)
	e4:SetCost(c64812349.negcost)
	e4:SetOperation(c64812349.negop)
	c:RegisterEffect(e4)	
end
function c64812349.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c64812349.negcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsFaceup() and tc:IsSetCard(0x8fc)
		and tc:IsControler(tp) and tc:IsLocation(LOCATION_MZONE)
end
function c64812349.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return (c:IsDiscardable() and c:IsLocation(LOCATION_HAND)) or (c:IsReleasable() and c:IsLocation(LOCATION_MZONE)) end
	if c:IsLocation(LOCATION_HAND) then Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
	else
	   Duel.Release(c,REASON_COST)
	end
end
function c64812349.negop(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetAttacker()
	if Duel.NegateAttack() and ac:IsRelateToBattle() and ac:IsCanTurnSet() and Duel.SelectYesNo(tp,aux.Stringid(64812349,1)) then
		Duel.ChangePosition(ac,POS_FACEDOWN_DEFENSE)
	end
end