--寂静之永恒黑洞龙·改
function c233610.initial_effect(c)
    --xyz summon
	aux.AddXyzProcedure(c,nil,12,5)
	c:EnableReviveLimit()
	--xyz
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetDescription(aux.Stringid(233610,0))
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1,233610+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c233610.xyzcon)
	e1:SetOperation(c233610.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e2)
	--summon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c233610.sumsuc)
	c:RegisterEffect(e3)
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_IGNORE_RANGE)
	e4:SetCode(EFFECT_SET_ATTACK_FINAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(0)
    e4:SetCondition(c233610.con)
	e4:SetTarget(c233610.atktg)
	c:RegisterEffect(e4)
	--def
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD)
	e13:SetProperty(EFFECT_FLAG_IGNORE_RANGE)
	e13:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e13:SetRange(LOCATION_MZONE)
	e13:SetValue(0)
    e13:SetCondition(c233610.con)
	e13:SetTarget(c233610.atktg)
	c:RegisterEffect(e13)

	--destroy
	local e15=Effect.CreateEffect(c)
	e15:SetCategory(CATEGORY_DESTROY)
	e15:SetDescription(aux.Stringid(233610,1))
	e15:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e15:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e15:SetCode(EVENT_SPSUMMON_SUCCESS)
	e15:SetProperty(EFFECT_FLAG_REPEAT)
	--e15:SetCost(c233610.descost)
	e15:SetTarget(c233610.destg)
	e15:SetOperation(c233610.desop)
	c:RegisterEffect(e15)
	--nil
	local e61=Effect.CreateEffect(c)
    e61:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e61:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
    e61:SetCode(EVENT_CHAINING)
    e61:SetRange(LOCATION_MZONE)
	e61:SetOperation(c233610.nilop)
    c:RegisterEffect(e61)
	--lp=atk
	local e66=Effect.CreateEffect(c)
	e66:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e66:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e66:SetRange(LOCATION_MZONE)
	e66:SetCode(EVENT_BATTLED)
	e66:SetCondition(c233610.bcon)
	e66:SetOperation(c233610.lpop)
	c:RegisterEffect(e66)
end	
--xyz
function c233610.xyzfilter(c)
	return c:IsRankAbove(1)
end
function c233610.rfilter(c,lv)
	return c:GetRank()==lv
end
function c233610.xyzcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
	and Duel.GetLocationCountFromEx(tp,tp,e:GetHandler())<0 then return false end
	return Duel.GetLocationCountFromEx(tp)>0 and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,5,nil,0x800000) 
end
function c233610.xyzop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	--local g=Duel.SelectMatchingCard(tp,c233610.xyzfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local g=Duel.GetMatchingGroup(c233610.xyzfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	local g1=g:Select(tp,1,1,nil)
	g:Remove(c233610.rfilter,nil,g1:GetFirst():GetRank())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g2=g:Select(tp,1,1,nil)
	g:Remove(c233610.rfilter,nil,g2:GetFirst():GetRank())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g3=g:Select(tp,1,1,nil)
	g:Remove(c233610.rfilter,nil,g3:GetFirst():GetRank())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g4=g:Select(tp,1,1,nil)
	g:Remove(c233610.rfilter,nil,g4:GetFirst():GetRank())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local g5=g:Select(tp,1,1,nil)
	g1:Merge(g2)
	g1:Merge(g3)
	g1:Merge(g4)
	g1:Merge(g5)
	c:SetMaterial(g1)
	Duel.Overlay(c,g1)
end
function c233610.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c233610.chlimit(tp))
end
function c233610.chlimit(p)
   return function (re,rp,tp)
	     return  p==tp 
    end
end
function c233610.con(e)
	return e:GetHandler():GetOverlayCount()~=0
end
function c233610.atktg(e,c)
    return not(c:IsType(TYPE_XYZ) and c:GetRank()==12)
end 
--destroy
function c233610.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c233610.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c233610.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0xc,0xc,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0xc,0xc,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c233610.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0xc,0xc,e:GetHandler())
	if g:GetCount()>0 then
	Duel.Destroy(g,REASON_EFFECT)
	end
end
function c233610.nilop(e,tp,eg,ep,ev,re,r,rp)
    c233610["effect"]=re:GetOperation()
	if re~=e then
    Duel.ChangeChainOperation(ev,c233610.zero) 
    end
end
function c233610.zero(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsType,tp,0xff,0xff,nil,0x1) 
    local tc=g:GetFirst()
      while tc do
      tc:AssumeProperty(ASSUME_ATTACK,0)
      tc=g:GetNext()
    end
        local te=c233610["effect"]
        if te then
        te(e,tp,eg,ep,ev,re,r,rp)
     end
end
--lp=atk
function c233610.bcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker()
end
function c233610.lpop(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase==PHASE_DAMAGE and not Duel.IsDamageCalculated()) or phase==PHASE_DAMAGE_CAL then return end
	local lp=e:GetHandler():GetAttack()
	Duel.SetLP(1-tp,lp)
end