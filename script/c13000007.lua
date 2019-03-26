--虚拟歌姬 星尘
function c13000007.initial_effect(c)
    c:SetUniqueOnField(1,0,13000007)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(13000007,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_HAND)
    e1:SetCountLimit(1,13000007)
    e1:SetCondition(c13000007.hspcon)
    e1:SetTarget(c13000007.hsptg)
    e1:SetOperation(c13000007.hspop)
    c:RegisterEffect(e1)
    local e1_1=e1:Clone()
    e1_1:SetType(EFFECT_TYPE_QUICK_O)
    e1_1:SetCode(EVENT_FREE_CHAIN)
    e1_1:SetHintTiming(0,TIMING_END_PHASE)
    e1_1:SetCondition(c13000007.hspcon2)
    c:RegisterEffect(e1_1)
    --remove trigger
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(13000007,1))
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e3:SetCode(EVENT_REMOVE)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCondition(c13000007.socon)
    e3:SetTarget(c13000007.sotg)
    e3:SetOperation(c13000007.soop)
    c:RegisterEffect(e3)
    --remove
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(13000007,2))
    e2:SetCategory(CATEGORY_REMOVE)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCondition(c13000007.con1)
    e2:SetTarget(c13000007.rmtg)
    e2:SetOperation(c13000007.rmop)
    c:RegisterEffect(e2)
    local e2_1=e2:Clone()
    e2_1:SetType(EFFECT_TYPE_QUICK_O)
    e2_1:SetCode(EVENT_FREE_CHAIN)
    e2_1:SetHintTiming(0,TIMING_END_PHASE)
    e2_1:SetCondition(c13000007.con2)
    c:RegisterEffect(e2_1)
end
function c13000007.con1(e,tp,eg,ep,ev,re,r,rp)
    return not Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000007.con2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000007.hspfilter(c)
    return c:IsSetCard(0x130) and c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c13000007.hspcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(c13000007.hspfilter,tp,LOCATION_REMOVED,0,1,nil) and not Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000007.hspcon2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(c13000007.hspfilter,tp,LOCATION_REMOVED,0,1,nil) and Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000007.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13000007.hspop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) then 
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c13000007.socon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_EFFECT) and e:GetOwner()~=re:GetOwner() and Duel.GetFlagEffect(tp,13000007)==0
end
function c13000007.sotg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.RegisterFlagEffect(tp,13000007,RESET_PHASE+PHASE_END,0,1)
end
function c13000007.soop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
    if g:GetCount()>0 then
        local mg=Group.CreateGroup()
        Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(13000007,3))
        local g1=g:FilterSelect(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_EARTH)
        Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(13000007,4))
        local g2=g:FilterSelect(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_WATER)
        Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(13000007,5))
        local g3=g:FilterSelect(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_FIRE)
        Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(13000007,6))
        local g4=g:FilterSelect(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_WIND)
        mg:Merge(g1)
        mg:Merge(g2)
        mg:Merge(g3)
        mg:Merge(g4)
        if mg:GetCount()>0 then 
            Duel.ShuffleDeck(tp)
            Duel.ConfirmCards(1-tp,mg)
            for sc in aux.Next(mg) do
                Duel.MoveSequence(sc,0)
            end
            Duel.SortDecktop(tp,tp,mg:GetCount())
        end
    end
end
function c13000007.rmfilter(c)
    return c:IsAbleToRemove()
end
function c13000007.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then 
        if chkc then return chkc:GetLocation()==LOCATION_MZONE and c13000007.rmfilter(chkc) end
        return Duel.IsExistingTarget(c13000007.rmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) 
    end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectTarget(tp,c13000007.rmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
end
function c13000007.rmop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if not c:IsRelateToEffect(e) and not tc:IsRelateToEffect(e) or not tc:IsType(TYPE_MONSTER) then return end
    Duel.Remove(tc,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE+PHASE_END)
    e1:SetReset(RESET_PHASE+PHASE_END)
    e1:SetLabelObject(tc)
    e1:SetCountLimit(1)
    e1:SetOperation(c13000007.retop)
    Duel.RegisterEffect(e1,tp)
end
function c13000007.retop(e,tp,eg,ep,ev,re,r,rp)
    Duel.ReturnToField(e:GetLabelObject())
end
