--化学奇妙实验室
function c44455000.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--name change
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44455000,0))
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetCountLimit(2,44455000)
	e11:SetRange(LOCATION_FZONE)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetTarget(c44455000.ntg)
	e11:SetOperation(c44455000.nop)
	c:RegisterEffect(e11)
	--to grave
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(44455000,1))
	e12:SetType(EFFECT_TYPE_IGNITION)
	e12:SetCountLimit(1,44455001)
	e12:SetCategory(CATEGORY_TOGRAVE)
	e12:SetRange(LOCATION_FZONE)
	e12:SetTarget(c44455000.tgtg)
	e12:SetOperation(c44455000.tgop)
	c:RegisterEffect(e12)
end
--name change
function c44455000.nfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x651) 
end
function c44455000.ntg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsControler(tp) and c44455000.nfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44455000.nfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	c44455000.announce_filter={0x651,OPCODE_ISSETCARD,TYPE_SPELL+TYPE_TRAP,OPCODE_ISTYPE,OPCODE_NOT,OPCODE_AND}
	local ac=Duel.AnnounceCardFilter(tp,table.unpack(c44455000.announce_filter))
	local g=Duel.SelectTarget(tp,c44455000.nfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	e:SetLabel(ac)
end
function c44455000.nop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
	    e1:SetCode(EFFECT_CHANGE_CODE)
	    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	    e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(e:GetLabel())
		tc:RegisterEffect(e1)
	end
end
--to grave
function c44455000.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGrave() and c:IsSetCard(0x654)
end
function c44455000.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44455000.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c44455000.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44455000.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
