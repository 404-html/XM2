--虚拟歌姬 乐正绫
function c13000006.initial_effect(c)
    c:SetUniqueOnField(1,0,13000006)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(13000006,0))
    e1:SetCategory(CATEGORY_REMOVE)
    e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetCountLimit(1,13000006)
    e1:SetTarget(c13000006.rmtg)
    e1:SetOperation(c13000006.rmop)
    c:RegisterEffect(e1)
    --remove trigger
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(13000006,1))
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e3:SetCategory(CATEGORY_DRAW)
    e3:SetCode(EVENT_REMOVE)
    e3:SetProperty(EFFECT_FLAG_DELAY)
    e3:SetCondition(c13000006.drcon)
    e3:SetTarget(c13000006.drtg)
    e3:SetOperation(c13000006.drop)
    c:RegisterEffect(e3)
    --up
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(13000006,2))
    e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DESTROY)
--  e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_BATTLE_START)
    e2:SetRange(LOCATION_MZONE)
--  e2:SetCountLimit(1)
    e2:SetCondition(c13000006.upcon)
    e2:SetCost(c13000006.upcost)
    e2:SetOperation(c13000006.upop)
    c:RegisterEffect(e2)
end
function c13000006.rmfilter(c)
    return c:IsAbleToRemove() and c:IsSetCard(0x130)
end
function c13000006.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c13000006.rmfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,LOCATION_DECK)
end
function c13000006.rmop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c13000006.rmfilter,tp,LOCATION_DECK,0,nil)
    if g:GetCount()>0 then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
        local rg=g:Select(tp,1,1,nil)
        Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
    end
end
function c13000006.drcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_EFFECT) and e:GetOwner()~=re:GetOwner() and Duel.GetFlagEffect(tp,13000006)==0
end
function c13000006.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
    Duel.RegisterFlagEffect(tp,13000006,RESET_PHASE+PHASE_END,0,1)
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,0,1)
end
function c13000006.drop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Draw(p,d,REASON_EFFECT)
end
function c13000006.upfilter(c)
    return c:IsSetCard(0x130) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c13000006.upcon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local ph=Duel.GetCurrentPhase()
    return ph==PHASE_DAMAGE and (c==Duel.GetAttacker() or c==Duel.GetAttackTarget())
        and not Duel.IsDamageCalculated()
end
function c13000006.upcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c13000006.upfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectMatchingCard(tp,c13000006.upfilter,tp,LOCATION_DECK,0,1,1,nil)
    e:SetLabel(g:GetFirst():GetAttack())
    Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c13000006.upop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsFaceup() and c:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(e:GetLabel())
        e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_DAMAGE)
        c:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetDescription(aux.Stringid(13000006,2))
        e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
        e2:SetCode(EVENT_PHASE+PHASE_END)
        e2:SetRange(LOCATION_MZONE)
        e2:SetCountLimit(1)
        e2:SetTarget(c13000006.destg)
        e2:SetOperation(c13000006.desop)
        e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
        c:RegisterEffect(e2)
    end
end
function c13000006.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c13000006.desop(e,tp,eg,ep,ev,re,r,rp)
    if e:GetHandler():IsRelateToEffect(e) then
        Duel.Destroy(e:GetHandler(),REASON_EFFECT)
    end
end
