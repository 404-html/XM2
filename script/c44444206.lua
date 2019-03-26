--鸣狐-花
function c44444206.initial_effect(c)
	aux.EnableDualAttribute(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(44444206,1))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c44444206.target)
	e1:SetOperation(c44444206.operation)
	c:RegisterEffect(e1)
	--draw
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44444206,2))
	e11:SetCategory(CATEGORY_DRAW)
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e11:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e11:SetCode(EVENT_TO_DECK)
	e11:SetCountLimit(1,44444206)
	--e11:SetCondition(c44444206.con)
	e11:SetTarget(c44444206.tg)
	e11:SetOperation(c44444206.op)
	c:RegisterEffect(e11)
	--Level
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetCode(EFFECT_CHANGE_LEVEL)
	e12:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e12:SetValue(7)
	c:RegisterEffect(e12)
end
--indes
function c44444206.filter(c)
	return c:IsSetCard(0x642) and c:IsFaceup()
end
function c44444206.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44444206.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44444206.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c44444206.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c44444206.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(tp) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetValue(c44444206.efilter)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetOwnerPlayer(tp)
		tc:RegisterEffect(e3)
	end
	Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
end
function c44444206.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer() and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
--draw
function c44444206.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSequence()==0
end
function c44444206.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c44444206.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end