--天真无邪的恶魔☯依莉斯
function c10101.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,3,3)	
	--self destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c10101.distg)
	c:RegisterEffect(e3)
	--move
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10101,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c10101.seqtg)
	e2:SetOperation(c10101.seqop)
	c:RegisterEffect(e2)
end
function c10101.distg(e,c)
	return e:GetHandler():GetLinkedGroup() and e:GetHandler():GetLinkedGroup():IsContains(c)
end
function c10101.filter(c)
	local p=c:GetControler()
	return Duel.GetLocationCount(p,LOCATION_MZONE,p)>0
end
function c10101.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c10101.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10101.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(10101,2))
	Duel.SelectTarget(tp,c10101.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c10101.seqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local p=tc:GetControler()
	if Duel.GetLocationCount(p,LOCATION_MZONE)>0 then
		local s=0
		if tc:IsControler(tp) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
			s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
			s=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)/0x10000
		end
		local nseq=0
		if s==1 then nseq=0
		elseif s==2 then nseq=1
		elseif s==4 then nseq=2
		elseif s==8 then nseq=3
		else nseq=4 end
		Duel.MoveSequence(tc,nseq)
	end
end