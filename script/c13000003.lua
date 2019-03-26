--虚拟歌姬 言和
function c13000003.initial_effect(c)
    c:SetUniqueOnField(1,0,13000003)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(13000003,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DISABLE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_HAND)
    e1:SetCountLimit(1,13000003)
    e1:SetCondition(c13000003.con1)
    e1:SetTarget(c13000003.hsptg)
    e1:SetOperation(c13000003.hspop)
    c:RegisterEffect(e1)
    local e1_1=e1:Clone()
    e1_1:SetType(EFFECT_TYPE_QUICK_O)
    e1_1:SetCode(EVENT_FREE_CHAIN)
    e1_1:SetHintTiming(0,TIMING_END_PHASE)
    e1_1:SetCondition(c13000003.con2)
    c:RegisterEffect(e1_1)
    --remove trigger
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(13000003,1))
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e3:SetCategory(CATEGORY_DRAW)
    e3:SetCode(EVENT_REMOVE)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCondition(c13000003.drcon)
    e3:SetTarget(c13000003.drtg)
    e3:SetOperation(c13000003.drop)
    c:RegisterEffect(e3)
    --token
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(13000003,2))
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCondition(c13000003.con1)
    e2:SetTarget(c13000003.tktg)
    e2:SetOperation(c13000003.tkop)
    c:RegisterEffect(e2)
    local e2_1=e2:Clone()
    e2_1:SetType(EFFECT_TYPE_QUICK_O)
    e2_1:SetCode(EVENT_FREE_CHAIN)
    e2_1:SetHintTiming(0,TIMING_END_PHASE)
    e2_1:SetCondition(c13000003.con2)
    c:RegisterEffect(e2_1)
end
function c13000003.con1(e,tp,eg,ep,ev,re,r,rp)
    return not Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000003.con2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000003.hspfilter(c)
    return c:IsFaceup()
end
function c13000003.hsptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then
        if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and c13000003.hspfilter(chkc) end
        return Duel.IsExistingTarget(c13000003.hspfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) 
            and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    local g=Duel.SelectTarget(tp,c13000003.hspfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,LOCATION_ONFIELD)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13000003.hspop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then 
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetReset(RESET_EVENT+RESETS_STANDARD)
        tc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_DISABLE_EFFECT)
        e2:SetReset(RESET_EVENT+RESETS_STANDARD)
        tc:RegisterEffect(e2)
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c13000003.drcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_EFFECT) and e:GetOwner()~=re:GetOwner() and Duel.GetFlagEffect(tp,13000003)==0
end
function c13000003.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDraw(1-tp,1) end
    Duel.RegisterFlagEffect(tp,13000003,RESET_PHASE+PHASE_END,0,1)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c13000003.drop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDraw(1-tp,1) and Duel.SelectYesNo(1-tp,aux.Stringid(13000003,3)) then
        Duel.Hint(HINT_OPSELECTED,tp,aux.Stringid(13000003,4))
        Duel.Draw(tp,1,REASON_EFFECT)
        Duel.Draw(1-tp,1,REASON_EFFECT)
    else
        Duel.Hint(HINT_OPSELECTED,tp,aux.Stringid(13000003,5))
    end
end
function c13000003.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
        and Duel.IsPlayerCanSpecialSummonMonster(tp,13000011,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_WIND,POS_FACEUP,1-tp) end
    Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c13000003.tkop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if not c:IsRelateToEffect(e) then return end
    if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<1 then return end
    if not Duel.IsPlayerCanSpecialSummonMonster(tp,13000011,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_WIND,POS_FACEUP,1-tp) then return end
    local token=Duel.CreateToken(tp,13000011)
    Duel.SpecialSummon(token,0,tp,1-tp,false,false,POS_FACEUP)
end
