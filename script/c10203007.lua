--玉 莲 飞 镖
function c10203007.initial_effect(c)
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_EQUIP)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCountLimit(1,10203007)
    e1:SetTarget(c10203007.target)
    e1:SetOperation(c10203007.activate)
    c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_REMOVE)
    e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e2:SetCountLimit(1,102030071)
    e2:SetTarget(c10203007.targets)
    e2:SetOperation(c10203007.activates)
    c:RegisterEffect(e2)
end
function c10203007.filter(c)
    return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c10203007.filters(c)
    return c:IsType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER)
end
function c10203007.cfilter(c,tp)
    return c:IsSetCard(0xe79e)
end
function c10203007.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsOnField() and c10203007.filter(chkc) and chkc~=e:GetHandler() end
    if chk==0 then return Duel.IsExistingTarget(c10203007.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectTarget(tp,c10203007.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c10203007.activate(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and Duel.IsExistingMatchingCard(c10203007.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) then
        Duel.Remove(tc,nil,REASON_EFFECT)
    elseif tc:IsRelateToEffect(e) then
        Duel.Destroy(tc,REASON_EFFECT)
    end
end
function c10203007.targets(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsOnField() and c10203007.filters(chkc) and chkc~=e:GetHandler() end
    if chk==0 then return Duel.IsExistingTarget(c10203007.filters,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
    local g=Duel.SelectTarget(tp,c10203007.filters,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c10203007.activates(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and Duel.IsExistingMatchingCard(c10203007.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) then
        Duel.Remove(tc,nil,REASON_EFFECT)
    elseif tc:IsRelateToEffect(e) then
        Duel.Destroy(tc,REASON_EFFECT)
    end
end