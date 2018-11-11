--猛毒性 交翼
function c24762460.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,4,c24762460.lcheck)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetDescription(aux.Stringid(24762460,0))
	e2:SetRange(LOCATION_MZONE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetTarget(c24762460.seqtg)
	e2:SetOperation(c24762460.seqop)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_CHAIN_NEGATED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c24762460.damcon)
	e1:SetOperation(c24762460.damop)
	c:RegisterEffect(e1)
end
function c24762460.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local btk=c:GetBaseAttack()
	local atk=c:GetAttack()
	if atk==0 then return end
	local ct=atk-btk
	Duel.SetLP(1-tp,Duel.GetLP(1-tp)-ct)
end
function c24762460.damcon(e,tp,eg,ep,ev,re,r,rp)
	local atk=e:GetHandler():GetAttack()
	if atk==0 then return end
	local de,dp=Duel.GetChainInfo(ev,CHAININFO_DISABLE_REASON,CHAININFO_DISABLE_PLAYER)
	return de and dp~=tp and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and re:GetHandler():IsSetCard(0x9390) and rp==tp
end
function c24762460.g2fil(c,tp)
	return c:GetAttack()>0 and c:IsControler(1-tp) and c:IsLocation(LOCATION_MZONE) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c24762460.filter(c,ggc)
	local p=ggc:GetControler()
	local zone=bit.band(ggc:GetLinkedZone(),0x1f)
	return Duel.GetLocationCount(p,LOCATION_MZONE,p,LOCATION_REASON_CONTROL,zone)>0
end
function c24762460.seqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ggc=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c24762460.filter,tp,LOCATION_MZONE,0,1,nil,ggc) end
end
function c24762460.seqop(e,tp,eg,ep,ev,re,r,rp)
	local ggc=e:GetHandler()
	local p=ggc:GetControler()
	local zone=bit.band(ggc:GetLinkedZone(),0x1f)
	if Duel.GetLocationCount(p,LOCATION_MZONE,p,LOCATION_REASON_CONTROL,zone)>0 then
		local s=0
		if ggc:IsControler(tp) then
			local flag=bit.bxor(zone,0xff)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
			s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,flag)
		end
		local nseq=0
		if s==1 then nseq=0
		elseif s==2 then nseq=1
		elseif s==4 then nseq=2
		elseif s==8 then nseq=3
		else nseq=4 end
		if Duel.MoveSequence(ggc,nseq)~=0 then
Duel.BreakEffect()
		local g=ggc:GetColumnGroup():Filter(c24762460.g2fil,nil,tp)
			if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(24762460,1)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
				ga=g:Select(tp,0,1,nil)
				tc=ga:GetFirst()
				local atk=tc:GetBaseAttack()
				local e1=Effect.CreateEffect(ggc)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_ATTACK_FINAL)
				e1:SetValue(0)
				tc:RegisterEffect(e1)
				if ggc:IsRelateToEffect(e) and ggc:IsFaceup() then
					local e2=Effect.CreateEffect(ggc)
					e2:SetType(EFFECT_TYPE_SINGLE)
					e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
					e2:SetCode(EFFECT_UPDATE_ATTACK)
					e2:SetValue(atk)
					ggc:RegisterEffect(e2)
				end
			end
		end
	end
end
function c24762460.lcheck(g,lc)
	return g:IsExists(Card.IsSetCard,1,nil,0x9390)
end