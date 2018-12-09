--Answer·百濑莉绪·S
function c81008010.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,81008009,aux.FilterBoolFunction(Card.IsFusionType,TYPE_PENDULUM),1,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c81008010.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c81008010.sprcon)
	e2:SetOperation(c81008010.sprop)
	c:RegisterEffect(e2)
	--cannot be fusion material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--disable spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,1)
	e4:SetTarget(c81008010.slimit)
	c:RegisterEffect(e4)
end
function c81008010.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c81008010.cfilter(c,tp)
	return (c:IsFusionCode(81008009) or c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_MONSTER))
		and c:IsCanBeFusionMaterial() and c:IsAbleToRemoveAsCost() and (c:IsControler(tp) or c:IsFaceup())
end
function c81008010.fcheck(c,sg)
	return c:IsFusionCode(81008009) and sg:FilterCount(c81008010.fcheck2,c)+1==sg:GetCount()
end
function c81008010.fcheck2(c)
	return c:IsType(TYPE_PENDULUM) and c:IsType(TYPE_MONSTER)
end
function c81008010.fgoal(c,tp,sg)
	return sg:GetCount()>1 and Duel.GetLocationCountFromEx(tp,tp,sg)>0 and sg:IsExists(c81008010.fcheck,1,nil,sg)
end
function c81008010.fselect(c,tp,mg,sg)
	sg:AddCard(c)
	local res=c81008010.fgoal(c,tp,sg) or mg:IsExists(c81008010.fselect,1,sg,tp,mg,sg)
	sg:RemoveCard(c)
	return res
end
function c81008010.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c81008010.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,tp)
	local sg=Group.CreateGroup()
	return mg:IsExists(c81008010.fselect,1,nil,tp,mg,sg)
end
function c81008010.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c81008010.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,tp)
	local sg=Group.CreateGroup()
	while true do
		local cg=mg:Filter(c81008010.fselect,sg,tp,mg,sg)
		if cg:GetCount()==0
			or (c81008010.fgoal(c,tp,sg) and not Duel.SelectYesNo(tp,210)) then break end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=cg:Select(tp,1,1,nil)
		sg:Merge(g)
	end
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetValue(sg:GetCount()*1000)
	c:RegisterEffect(e1)
end
function c81008010.slimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end