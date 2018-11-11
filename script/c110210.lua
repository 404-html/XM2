--蜘蛛「石窟的蜘蛛巢」
function c110210.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCost(c110210.cost)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--adjust
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_ADJUST)
	e0:SetRange(LOCATION_SZONE)
	e0:SetOperation(c110210.adjustop)
	c:RegisterEffect(e0)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e0:SetLabelObject(g)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c110210.disable)
	e2:SetCode(EFFECT_DISABLE)
	Duel.RegisterEffect(e2,0)
	--act in hand
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	c:RegisterEffect(e3)
	--
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(110511,3))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetCost(c110210.negcost)
	e5:SetTarget(c110210.dldtg2)
	e5:SetOperation(c110210.dldop2)
	c:RegisterEffect(e5)
end
function c110210.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,1,REASON_COST)
end
function c110210.filter0(c)
	return c:IsDisabled() and c:IsFaceup()
end
function c110210.dldtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c110210.filter0,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c110210.filter0,tp,0,LOCATION_ONFIELD,nil)
	local tg=g:GetMaxGroup(Card.GetAttack)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,tg,tg:GetCount(),0,0)
	e:SetCategory(CATEGORY_TOGRAVE)
end
function c110210.dldop2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c110210.filter0,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end

function c110210.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:GetHandler():IsStatus(STATUS_ACT_FROM_HAND) and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) then
		Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
	end
end
function c110210.filter(c)
	return c:IsDisabled() or bit.band(c:GetType(),TYPE_EFFECT)==0 or c:IsFacedown()
end
function c110210.filter2(c)
	return not c:IsDisabled() and bit.band(c:GetType(),TYPE_EFFECT)>0 and c:IsFaceup()
end
function c110210.disable(e,c)
	return c:GetFlagEffect(110210)>0 and bit.band(c:GetType(),TYPE_EFFECT)>0
end 
function c110210.adjustop(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandlerPlayer()
	local phase=Duel.GetCurrentPhase()
	if (phase==PHASE_DAMAGE and not Duel.IsDamageCalculated()) or phase==PHASE_DAMAGE_CAL then return end
	local c=e:GetHandler()
	local pg=e:GetLabelObject()
	if c:GetFlagEffect(110211)==0 then
		c:RegisterFlagEffect(110211,RESET_EVENT+0x1ff0000,0,0)
		pg:Clear()
	end
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
	local dg=g:Filter(c110210.filter,nil)
	if dg:GetCount()==0 and Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)>0 then
		local tc=Duel.SelectMatchingCard(1-tp,c110210.filter2,1-tp,LOCATION_MZONE,0,1,1,nil)
		if tc and tc:GetCount()>0 then
			tc=tc:GetFirst()
			tc:RegisterFlagEffect(110210,RESET_EVENT+0x1fe0000,0,0)			
		end 
		pg:Clear()
		pg:Merge(g)
		pg:Sub(dg)
	else
		g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
		pg:Clear()
		pg:Merge(g)
		pg:Sub(dg)
		--Duel.Readjust()
	end
end

