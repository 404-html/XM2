--我的痛苦在你之上啊！
function c91000006.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,91000006+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c91000006.condition)
	e1:SetOperation(c91000006.activate)
	c:RegisterEffect(e1)
end
function c91000006.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)>Duel.GetLP(1-tp)
end
function c91000006.activate(e,tp,eg,ep,ev,re,r,rp)
	local p1=Duel.GetLP(tp)
	local p2=Duel.GetLP(1-tp)
	local s=p1-p2
	Duel.SetLP(tp,p1-s)
	Duel.SetLP(1-tp,p2-s)
		if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_PHASE+PHASE_END)
			e2:SetCountLimit(1)
			e2:SetLabel(s)
			e2:SetReset(RESET_PHASE+PHASE_END)
			e2:SetOperation(c91000006.damop)
			Duel.RegisterEffect(e2,tp)
		end
end
function c91000006.damop(e,tp,eg,ep,ev,re,r,rp)
	local p1=Duel.GetLP(tp)		
	Duel.SetLP(tp,p1-e:GetLabel())
end