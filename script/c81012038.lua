--Answer·栋方爱海
function c81012038.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(3)
	e1:SetValue(c81012038.valcon)
	c:RegisterEffect(e1)
end
function c81012038.valcon(e,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0
end