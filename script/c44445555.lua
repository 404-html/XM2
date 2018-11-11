--岚风雷鸟
function c44445555.initial_effect(c)
    --synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsAttribute,ATTRIBUTE_WIND),1)
    --can not disable summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c44445555.effcon)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44445555,4))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c44445555.condition)
	e2:SetTarget(c44445555.target)
	e2:SetOperation(c44445555.operation)
	c:RegisterEffect(e2)
	--atkup
   	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_UPDATE_ATTACK)
	e9:SetValue(c44445555.value)
	c:RegisterEffect(e9)
end
function c44445555.effcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c44445555.value(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_SZONE,LOCATION_SZONE)*500
end
function c44445555.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(0xc)
end
function c44445555.sfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c44445555.dfilter(c)
	return not c:IsAttribute(ATTRIBUTE_WIND)
end
function c44445555.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local op=0
	local g1=Duel.GetMatchingGroup(c44445555.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	local g2=Duel.GetMatchingGroup(c44445555.sfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(44445555,0))
	if g1:GetCount()>0 and g2:GetCount()>0 then
		op=Duel.SelectOption(tp,aux.Stringid(44445555,1),aux.Stringid(44445555,2))+1
	elseif g1:GetCount()>0 then
		op=Duel.SelectOption(tp,aux.Stringid(44445555,1))+1
	elseif g2:GetCount()>0 then
		op=Duel.SelectOption(tp,aux.Stringid(44445555,2))+2
	end
	if op==1 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
	elseif op==2 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,g2:GetCount(),0,0)
	end
	e:SetLabel(op)
end
function c44445555.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 then
		local g=Duel.GetMatchingGroup(c44445555.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
		local tc=g:GetFirst()
	    while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()/2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	    end
	elseif e:GetLabel()==2 then
		local g=Duel.GetMatchingGroup(c44445555.sfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
