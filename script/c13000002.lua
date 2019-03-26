--虚拟歌姬 洛天依
function c13000002.initial_effect(c)
    c:SetUniqueOnField(1,0,13000002)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(13000002,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_HAND)
    e1:SetCountLimit(1,13000002)
    e1:SetCondition(c13000002.con1)
    e1:SetCost(c13000002.hspcost)
    e1:SetTarget(c13000002.hsptg)
    e1:SetOperation(c13000002.hspop)
    c:RegisterEffect(e1)
    local e1_1=e1:Clone()
    e1_1:SetType(EFFECT_TYPE_QUICK_O)
    e1_1:SetCode(EVENT_FREE_CHAIN)
    e1_1:SetHintTiming(0,TIMING_END_PHASE)
    e1_1:SetCondition(c13000002.con2)
    c:RegisterEffect(e1_1)
    --remove trigger
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(13000002,1))
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e3:SetCategory(CATEGORY_REMOVE)
    e3:SetCode(EVENT_REMOVE)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCondition(c13000002.rmcon)
    e3:SetTarget(c13000002.rmtg)
    e3:SetOperation(c13000002.rmop)
    c:RegisterEffect(e3)
    --equip
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(13000002,2))
    e2:SetCategory(CATEGORY_EQUIP)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCondition(c13000002.con1)
    e2:SetTarget(c13000002.eqtg)
    e2:SetOperation(c13000002.eqop)
    c:RegisterEffect(e2)
    local e2_1=e2:Clone()
    e2_1:SetType(EFFECT_TYPE_QUICK_O)
    e2_1:SetCode(EVENT_FREE_CHAIN)
    e2_1:SetHintTiming(0,TIMING_END_PHASE)
    e2_1:SetCondition(c13000002.con2)
    c:RegisterEffect(e2_1)
end
function c13000002.con1(e,tp,eg,ep,ev,re,r,rp)
    return not Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000002.con2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000002.hspcost(e,tp,eg,ep,ev,re,r,rp,chk)
    local g=Duel.GetDecktopGroup(tp,10)
    if chk==0 then return g:FilterCount(Card.IsAbleToRemoveAsCost,nil)==10
        and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=10 end
    Duel.DisableShuffleCheck()
    Duel.Remove(g,POS_FACEDOWN,REASON_COST)
end
function c13000002.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13000002.hspop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) then 
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c13000002.retop(e,tp,eg,ep,ev,re,r,rp)
    Duel.ReturnToField(e:GetLabelObject())
end
function c13000002.rmcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_EFFECT) and e:GetOwner()~=re:GetOwner() and Duel.GetFlagEffect(tp,13000002)==0
end
function c13000002.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
    Duel.RegisterFlagEffect(tp,13000002,RESET_PHASE+PHASE_END,0,1)
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,Duel.GetFieldGroupCount(tp,0,LOCATION_HAND),1-tp,LOCATION_HAND)
end
function c13000002.rmop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_HAND,nil)
    if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
        c13000002.announce_filter={TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK,OPCODE_ISTYPE,OPCODE_NOT}
        local ac=Duel.AnnounceCardFilter(tp,table.unpack(c13000002.announce_filter))
        Duel.ConfirmCards(tp,g)
        if g:IsExists(Card.IsCode,1,nil,ac) then 
            local rg=g:Filter(Card.IsCode,nil,ac)
            Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
        end
    end
end
function c13000002.eqfilter(c)
    return c:IsLocation(LOCATION_MZONE) or c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c13000002.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then 
        if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c13000002.eqfilter(chkc) end
        return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 
            and Duel.IsExistingTarget(c13000002.eqfilter,tp,0,LOCATION_MZONE,1,nil) 
    end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
    local g=Duel.SelectTarget(tp,c13000002.eqfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c13000002.eqop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if not tc:IsRelateToEffect(e) or not tc:IsType(TYPE_MONSTER) then return end
    if Duel.GetMatchingGroupCount(Card.IsAbleToRemove,tp,LOCATION_HAND,0,nil)>0 then 
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
        local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,1,nil)
        Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
    end
    if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or c:IsFacedown() or not c:IsRelateToEffect(e) then
        if tc:IsLocation(LOCATION_MZONE) then Duel.SendtoGrave(tc,REASON_EFFECT) end
        return
    end
    Duel.Equip(tp,tc,c,false)
    local e1=Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_EQUIP_LIMIT)
    e1:SetReset(RESET_EVENT+RESETS_STANDARD)
    e1:SetValue(c13000002.eqlimit)
    tc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
        e2:SetCode(EFFECT_CHANGE_CODE)
        e2:SetRange(LOCATION_SZONE)
        e2:SetReset(RESET_EVENT+RESETS_STANDARD)
        e2:SetValue(13000010)
        tc:RegisterEffect(e2)
end
function c13000002.eqlimit(e,c)
    return e:GetOwner()==c
end
