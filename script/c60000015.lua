--皇家进化源 V仔兽
function c60000015.initial_effect(c)
	--ritual level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_RITUAL_LEVEL)
	e1:SetValue(c60000015.rlevel)
	c:RegisterEffect(e1)
	--destroy sub
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e3:SetValue(c60000015.repval)
	c:RegisterEffect(e3)
	--Atk up
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(1000)
	c:RegisterEffect(e5)
end
function c60000015.rlevel(e,c)
	local lv=e:GetHandler():GetLevel()
	if (c:IsCode(60000006)or c:IsCode(60000007)) then
		local clv=c:GetLevel()
		return lv*65536+clv
	else return lv end
end
function c60000015.repval(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end