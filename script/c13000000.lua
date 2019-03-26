--虚拟歌姬 初音未来
function c13000000.initial_effect(c)
    c:SetUniqueOnField(1,0,13000000)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(13000000,0))
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e1:SetRange(LOCATION_HAND)
    e1:SetValue(1)
    e1:SetCountLimit(1,13000000)
    e1:SetCondition(c13000000.hspcon)
    c:RegisterEffect(e1)
    --remove trigger
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(13000000,1))
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
    e3:SetCode(EVENT_REMOVE)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCondition(c13000000.thcon)
    e3:SetTarget(c13000000.thtg)
    e3:SetOperation(c13000000.thop)
    c:RegisterEffect(e3)
    --no battle damage
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_NO_BATTLE_DAMAGE)
    e2:SetValue(1)
    c:RegisterEffect(e2)
    local e2_1=e2:Clone()
    e2_1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
    c:RegisterEffect(e2_1)
end
function c13000000.hspcon(e,c)
    if c==nil then return true end
    return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
        and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c13000000.thcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_EFFECT) and e:GetOwner()~=re:GetOwner() and Duel.GetFlagEffect(tp,13000000)==0
end
function c13000000.thfilter(c)
    return c:IsSetCard(0x130) and c:IsAbleToHand()
end
function c13000000.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c13000000.thfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.RegisterFlagEffect(tp,13000000,RESET_PHASE+PHASE_END,0,1)
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13000000.thop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c13000000.thfilter,tp,LOCATION_DECK,0,nil)
    if g:GetCount()>0 then
        local thg=g:RandomSelect(tp,1)
        Duel.SendtoHand(thg,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,thg)
    end
end
