--虚拟歌姬 东方栀子
function c13000001.initial_effect(c)
    c:SetUniqueOnField(1,0,13000001)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(13000001,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_HAND)
    e1:SetCountLimit(1,13000001)
    e1:SetCondition(c13000001.con1)
    e1:SetTarget(c13000001.hsptg)
    e1:SetOperation(c13000001.hspop)
    c:RegisterEffect(e1)
    local e1_1=e1:Clone()
    e1_1:SetType(EFFECT_TYPE_QUICK_O)
    e1_1:SetCode(EVENT_FREE_CHAIN)
    e1_1:SetHintTiming(0,TIMING_END_PHASE)
    e1_1:SetCondition(c13000001.con2)
    c:RegisterEffect(e1_1)
    --remove trigger
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(13000001,1))
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e3:SetCategory(CATEGORY_REMOVE)
    e3:SetCode(EVENT_REMOVE)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCondition(c13000001.rmcon)
    e3:SetTarget(c13000001.rmtg)
    e3:SetOperation(c13000001.rmop)
    c:RegisterEffect(e3)
    --self destroy
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(13000001,2))
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCode(EVENT_PHASE+PHASE_END)
    e2:SetCondition(c13000001.descon)
    e2:SetTarget(c13000001.destg)
    e2:SetOperation(c13000001.desop)
    c:RegisterEffect(e2)
end
function c13000001.con1(e,tp,eg,ep,ev,re,r,rp)
    return not Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000001.con2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000001.hspfilter(c)
    return c:IsAbleToRemove()
end
function c13000001.hsptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then
        if chkc then return chkc:GetLocation()==LOCATION_MZONE and c13000001.hspfilter(chkc) end
        return Duel.IsExistingTarget(c13000001.hspfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
            and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) 
    end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectTarget(tp,c13000001.hspfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,LOCATION_MZONE)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13000001.hspop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and Duel.Remove(tc,tc:GetPosition(),REASON_EFFECT+REASON_TEMPORARY)~=0 then 
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        e1:SetCode(EVENT_PHASE+PHASE_END)
        e1:SetReset(RESET_PHASE+PHASE_END)
        e1:SetLabelObject(tc)
        e1:SetCountLimit(1)
        e1:SetOperation(c13000001.retop)
        Duel.RegisterEffect(e1,tp)
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c13000001.retop(e,tp,eg,ep,ev,re,r,rp)
    Duel.ReturnToField(e:GetLabelObject())
end
function c13000001.rmcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_EFFECT) and e:GetOwner()~=re:GetOwner() and Duel.GetFlagEffect(tp,13000001)==0
end
function c13000001.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
    Duel.RegisterFlagEffect(tp,13000001,RESET_PHASE+PHASE_END,0,1)
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_ONFIELD)
end
function c13000001.rmop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
    if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
        local rg=g:Select(tp,1,1,nil)
        Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
    end
end
function c13000001.desfilter(c)
    return c:IsCode(13000009) and c:IsFaceup()
end
function c13000001.descon(e,tp,eg,ep,ev,re,r,rp)
    return not Duel.IsExistingMatchingCard(c13000001.desfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c13000001.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c13000001.desop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) and c:IsFaceup() then
        Duel.Destroy(c,REASON_EFFECT)
    end
end
