--虚拟歌姬 夏语遥
function c13000004.initial_effect(c)
    c:SetUniqueOnField(1,0,13000004)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(13000004,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_HAND)
    e1:SetCountLimit(1,13000004)
    e1:SetCondition(c13000004.con1)
    e1:SetCost(c13000004.hspcost)
    e1:SetTarget(c13000004.hsptg)
    e1:SetOperation(c13000004.hspop)
    c:RegisterEffect(e1)
    local e1_1=e1:Clone()
    e1_1:SetType(EFFECT_TYPE_QUICK_O)
    e1_1:SetCode(EVENT_FREE_CHAIN)
    e1_1:SetHintTiming(0,TIMING_END_PHASE)
    e1_1:SetCondition(c13000004.con2)
    c:RegisterEffect(e1_1)
    --remove trigger
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(13000004,1))
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e3:SetCode(EVENT_REMOVE)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCondition(c13000004.dspcon)
    e3:SetTarget(c13000004.dsptg)
    e3:SetOperation(c13000004.dspop)
    c:RegisterEffect(e3)
    --to hand
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(13000004,2))
    e2:SetCategory(CATEGORY_REMOVE+CATEGORY_TOHAND)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCondition(c13000004.con1)
    e2:SetTarget(c13000004.thtg)
    e2:SetOperation(c13000004.thop)
    c:RegisterEffect(e2)
    local e2_1=e2:Clone()
    e2_1:SetType(EFFECT_TYPE_QUICK_O)
    e2_1:SetCode(EVENT_FREE_CHAIN)
    e2_1:SetHintTiming(0,TIMING_END_PHASE)
    e2_1:SetCondition(c13000004.con2)
    c:RegisterEffect(e2_1)
end
function c13000004.con1(e,tp,eg,ep,ev,re,r,rp)
    return not Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000004.con2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsPlayerAffectedByEffect(tp,13000008)
end
function c13000004.hspcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
        and Duel.IsPlayerCanSpecialSummonMonster(tp,13000012,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_WIND,POS_FACEUP,1-tp) end
    local token=Duel.CreateToken(tp,13000012)
    Duel.SpecialSummon(token,0,tp,1-tp,false,false,POS_FACEUP)
end
function c13000004.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13000004.hspop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then 
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c13000004.dspcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_EFFECT) and e:GetOwner()~=re:GetOwner() and Duel.GetFlagEffect(tp,13000004)==0
end
function c13000004.dsptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c13000004.dspfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
    Duel.RegisterFlagEffect(tp,13000004,RESET_PHASE+PHASE_END,0,1)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c13000004.dspop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c13000004.dspfilter,tp,LOCATION_DECK,0,nil,e,tp)
    if g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then 
        local rg=g:RandomSelect(tp,1)
        Duel.SpecialSummon(rg,0,tp,tp,false,false,POS_FACEUP)
    end
end
function c13000004.dspfilter(c,e,tp)
    return c:IsSetCard(0x130) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13000004.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chk==0 then 
        if chkc then return c:IsLocation(LOCATION_ONFIELD) and c:IsControler(1-tp) end
        return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) 
            and Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
    local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,1-tp,LOCATION_ONFIELD)
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_ONFIELD)
end
function c13000004.thop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,0,e:GetHandler())
    if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) or g:GetCount()<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local rg=g:Select(tp,1,1,nil)
    Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
    Duel.SendtoHand(tc,nil,REASON_EFFECT)
end
