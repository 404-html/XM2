--真红眼炽黑龙炎剑
function c44470002.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c44470002.ffilter1,c44470002.ffilter2,true)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44470002,0))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c44470002.eqtg)
	e2:SetOperation(c44470002.eqop)
	c:RegisterEffect(e2)
	--fusion limit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	--atkup
	local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(44470002,1))
	e11:SetCategory(CATEGORY_ATKCHANGE)
	e11:SetType(EFFECT_TYPE_IGNITION)
	e11:SetRange(LOCATION_SZONE)
	e11:SetCountLimit(1,44470002)
	e11:SetCost(c44470002.atkcost)
	e11:SetOperation(c44470002.atkop)
	c:RegisterEffect(e11)
	--special summon rule
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD)
	e21:SetCode(EFFECT_SPSUMMON_PROC)
	e21:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e21:SetRange(LOCATION_EXTRA)
	e21:SetCondition(c44470002.spcon)
	e21:SetOperation(c44470002.spop)
	e21:SetValue(1)
	c:RegisterEffect(e21)
	--indes
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_EQUIP)
	e22:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e22:SetValue(1)
	c:RegisterEffect(e22)
end
--equip
function c44470002.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and chkc~=e:GetHandler() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
end
function c44470002.eqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsLocation(LOCATION_SZONE) or c:IsFacedown() then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(c44470002.eqlimit)
	e1:SetLabelObject(tc)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function c44470002.eqlimit(e,c)
	return c==e:GetLabelObject()
end
--atkup
function c44470002.thfilter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE)
	and c:IsType(TYPE_MONSTER)
	and c:GetLevel()==1
	and c:IsAbleToRemoveAsCost()
end
function c44470002.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44470002.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c44470002.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetAttack())
end
function c44470002.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_EQUIP)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(e:GetLabel())
			e1:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e1)
	end
end
--special summon rule
function c44470002.ffilter1(c)
	return c:IsFusionType(TYPE_NORMAL)
	and c:IsSetCard(0x3b)
end
function c44470002.ffilter2(c)
	return c:IsFusionAttribute(ATTRIBUTE_FIRE)
end
function c44470002.rfilter(c,fc)
	return (c44470002.ffilter1(c) or c44470002.ffilter2(c))
		and c:IsCanBeFusionMaterial(fc) and c:IsAbleToRemoveAsCost()
end
function c44470002.spfilter1(c,tp,g)
	return g:IsExists(c44470002.spfilter2,1,c,tp,c)
end
function c44470002.spfilter2(c,tp,mc)
	return (c44470002.ffilter1(c) and c44470002.ffilter2(mc)
		or c44470002.ffilter1(mc) and c44470002.ffilter2(c))
		and Duel.GetLocationCountFromEx(tp,tp,Group.FromCards(c,mc))>0
end
function c44470002.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetMatchingGroup(c44470002.rfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,c)
	return rg:IsExists(c44470002.spfilter1,1,nil,tp,rg)
end
function c44470002.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetMatchingGroup(c44470002.rfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=rg:FilterSelect(tp,c44470002.spfilter1,1,1,nil,tp,rg)
	local mc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=rg:FilterSelect(tp,c44470002.spfilter2,1,1,mc,tp,mc)
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.Remove(g1,POS_FACEUP,REASON_COST+REASON_FUSION+REASON_MATERIAL)
end

