--虚拟歌姬 心华
function c13000005.initial_effect(c)
    c:SetUniqueOnField(1,0,13000005)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(13000005,0))
    e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
    e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetCountLimit(1,13000005)
    e1:SetTarget(c13000005.thtg)
    e1:SetOperation(c13000005.thop)
    c:RegisterEffect(e1)
    --remove trigger
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(13000005,1))
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e3:SetCategory(CATEGORY_EQUIP)
    e3:SetCode(EVENT_REMOVE)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCondition(c13000005.eqcon)
    e3:SetTarget(c13000005.eqtg)
    e3:SetOperation(c13000005.eqop)
    c:RegisterEffect(e3)
    --to deck
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(13000005,2))
    e2:SetCategory(CATEGORY_TODECK)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCondition(c13000005.con1)
    e2:SetTarget(c13000005.tdtg)
    e2:SetOperation(c13000005.tdop)
    c:RegisterEffect(e2)
    local e2_1=e2:Clone()
    e2_1:SetType(EFFECT_TYPE_QUICK_O)
    e2_1:SetCode(EVENT_FREE_CHAIN)
    e2_1:SetHintTiming(0,TIMING_END_PHASE)
    e2_1:SetCondition(c13000005.con2)
    c:RegisterEffect(e2_1)
end
function c13000005.con1(e,tp,eg,ep,ev,re,r,rp)
    return not Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000005.con2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000005.thfilter(c)
    return c:IsAbleToHand() and c:IsSetCard(0x130)
end
function c13000005.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c13000005.thfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_SEARCH+CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c13000005.thop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c13000005.thfilter,tp,LOCATION_DECK,0,nil)
    if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
        local thg=g:Select(tp,1,1,nil)
        Duel.SendtoHand(thg,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,thg)
    end
end
function c13000005.eqcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_EFFECT) and e:GetOwner()~=re:GetOwner() and Duel.GetFlagEffect(tp,13000005)==0
end
function c13000005.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.IsExistingMatchingCard(c13000005.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
    Duel.RegisterFlagEffect(tp,13000005,RESET_PHASE+PHASE_END,0,1)
    Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_MZONE)
end
function c13000005.eqop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if not c:IsRelateToEffect(e) then return end
    local g=Duel.GetMatchingGroup(c13000005.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
    if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then 
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
        local eqg=g:Select(tp,1,1,nil)
        local tc=eqg:GetFirst()
        if tc:IsImmuneToEffect(e) then 
            Duel.SendtoGrave(c,REASON_EFFECT)
            return 
        end
        Duel.Equip(tp,c,tc,true)
        local e0=Effect.CreateEffect(c)
        e0:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
        e0:SetType(EFFECT_TYPE_SINGLE)
        e0:SetCode(EFFECT_EQUIP_LIMIT)
        e0:SetReset(RESET_EVENT+RESETS_STANDARD)
        e0:SetValue(c13000005.eqlimit)
        c:RegisterEffect(e0)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_EQUIP)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetReset(RESET_EVENT+RESETS_STANDARD)
        c:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_EQUIP)
        e2:SetCode(EFFECT_DISABLE_EFFECT)
        e2:SetReset(RESET_EVENT+RESETS_STANDARD)
        c:RegisterEffect(e2)
        local e3=Effect.CreateEffect(c)
        e3:SetType(EFFECT_TYPE_SINGLE)
        e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
        e3:SetCode(EFFECT_CHANGE_CODE)
        e3:SetRange(LOCATION_SZONE)
        e3:SetReset(RESET_EVENT+RESETS_STANDARD)
        e3:SetValue(13000013)
        c:RegisterEffect(e3)
    end
end
function c13000005.eqfilter(c)
    return c:IsFaceup() and (c:IsType(TYPE_MONSTER) or c:IsLocation(LOCATION_MZONE))
end
function c13000005.eqlimit(e,c)
    return c:IsFaceup()
end
function c13000005.tdfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x130) and c:IsAbleToDeck()
end
function c13000005.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then 
        if chkc then return c:IsLocation(LOCATION_REMOVED) and c13000005.tdfilter(chkc) end
        return Duel.IsExistingTarget(c13000005.tdfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
    local g=Duel.SelectTarget(tp,c13000005.tdfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,LOCATION_REMOVED)
end
function c13000005.tdop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then 
        Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
    end
end
