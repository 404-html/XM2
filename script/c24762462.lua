--猛毒性 淤垢
function c24762462.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,24762461,aux.FilterBoolFunction(Card.IsSetCard,0x9390),1,false,false)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c24762462.splimit)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24762462,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e2:SetCountLimit(1)
	e2:SetCondition(c24762462.e2con)
	e2:SetTarget(c24762462.e2tg)
	e2:SetOperation(c24762462.e2op)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetTarget(c24762462.e3reptg)
	e3:SetCondition(c24762462.e3repcon)
	e3:SetOperation(c24762462.e3repop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetRange(LOCATION_EXTRA)
	e4:SetCondition(c24762462.hspcon)
	e4:SetOperation(c24762462.hspop)
	c:RegisterEffect(e4)
end
function c24762462.spfil(c)
	return c:IsCanBeFusionMaterial() and c:IsSetCard(0x9390) and c:IsAbleToRemoveAsCost()
end
function c24762462.fselect(c,tp,mg,sg)
	sg:AddCard(c)
	local res=false
	if sg:GetCount()<1 then
		res=mg:IsExists(c24762462.fselect,1,sg,tp,mg,sg)
	else
		res=Duel.GetLocationCountFromEx(tp,tp,sg)>0
	end
	sg:RemoveCard(c)
	return res
end
function c24762462.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c24762462.spfil,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	local sg=Group.CreateGroup()
	return Duel.GetFlagEffect(tp,24762462)==0 and mg:IsExists(c24762462.fselect,1,nil,tp,mg,sg)
end
function c24762462.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c24762462.spfil,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	local sg=Group.CreateGroup()
	while sg:GetCount()<1 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=mg:FilterSelect(tp,c24762462.fselect,1,2,sg,tp,mg,sg)
		sg:Merge(g)
	Duel.Remove(sg,POS_FACEUP,REASON_COST+REASON_FUSION+REASON_MATERIAL)
	end
	Duel.RegisterFlagEffect(tp,24762462,RESET_PHASE+PHASE_END,0,1)
end
function c24762462.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION or se:GetHandler():IsCode(24562458)
end
function c24762462.e2con(e)
	local tp=e:GetHandler():GetControler()
	return Duel.IsExistingMatchingCard(c24762462.e3rmfil,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil)
end
function c24762462.e3repcon(e)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_FUSION)
end
function c24762462.e3repop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=e:GetHandler()
	Duel.MoveToField(tc,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
	local e11=Effect.CreateEffect(tc)
	e11:SetDescription(aux.Stringid(24762462,1))
	e11:SetCode(EFFECT_CHANGE_TYPE)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
	e11:SetReset(RESET_EVENT+0x1fc0000)
	e11:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
	tc:RegisterEffect(e11)
	Duel.RaiseEvent(tc,EVENT_CUSTOM+47408488,e,0,tp,0,0)
end
function c24762462.e3reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0 end
end
function c24762462.e2tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local vd=Duel.GetMatchingGroupCount(c24762462.e3rmfil,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	local gs=Duel.GetMatchingGroupCount(c24762462.e2rcfil,tp,LOCATION_MZONE,0,nil)
	e:SetLabel(gs)
	if gs==0 then
		e:SetCategory(CATEGORY_DAMAGE)
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(vd*500)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,vd*500)
	else
		e:SetCategory(CATEGORY_RECOVER)
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(vd*500)
		Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,vd*500)
	end
end
function c24762462.e2op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if e:GetLabel()==0 then
	   Duel.Damage(p,d,REASON_EFFECT)
	else Duel.Recover(p,d,REASON_EFFECT) end
end
function c24762462.e3rmfil(c)
	return c:IsFaceup() and c:IsCode(24762461)
end
function c24762462.e2rcfil(c)
	return c:IsFaceup() and c:IsSetCard(0x9390) and c:IsType(TYPE_MONSTER)
end