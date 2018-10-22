--季神-玛奇
function c50218315.initial_effect(c)
    c:EnableReviveLimit()
    aux.EnablePendulumAttribute(c)
    --splimit
    local e0=Effect.CreateEffect(c)
    e0:SetType(EFFECT_TYPE_FIELD)
    e0:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e0:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
    e0:SetRange(LOCATION_PZONE)
    e0:SetTargetRange(1,0)
    e0:SetTarget(c50218315.splimit)
    c:RegisterEffect(e0)
    --tohand
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_PZONE)
    e1:SetCountLimit(1,50218315)
    e1:SetTarget(c50218315.target)
    e1:SetOperation(c50218315.activate)
    c:RegisterEffect(e1)
    --cannot activate
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_ACTIVATE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetTargetRange(0,1)
    e2:SetCondition(c50218315.actcon)
    e2:SetValue(c50218315.afilter)
    c:RegisterEffect(e2)
    --to deck
    local e3=Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_TODECK)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e3:SetCode(EVENT_SPSUMMON_SUCCESS)
    e3:SetCountLimit(1,50218316)
    e3:SetCondition(c50218315.tdcon)
    e3:SetTarget(c50218315.tdtg)
    e3:SetOperation(c50218315.tdop)
    c:RegisterEffect(e3)
    --draw
    local e4=Effect.CreateEffect(c)
    e4:SetCategory(CATEGORY_DRAW)
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
    e4:SetCode(EVENT_RELEASE)
    e4:SetCountLimit(1,50218316)
    e4:SetTarget(c50218315.drtg)
    e4:SetOperation(c50218315.drop)
    c:RegisterEffect(e4)
end
function c50218315.splimit(e,c,tp,sumtp,sumpos)
    return not c:IsSetCard(0xcb3)
end
function c50218315.filter(c)
    return c:IsSetCard(0xcb3) and not c:IsCode(50218315) and c:IsAbleToHand()
end
function c50218315.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c50218315.filter,tp,LOCATION_EXTRA,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c50218315.activate(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)>0 then
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,c50218315.filter,tp,LOCATION_EXTRA,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
    end
    end
end
function c50218315.actcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c50218315.afilter(e,re,tp)
    return re:GetHandler():GetType()==TYPE_TRAP and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c50218315.tdcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c50218315.tdfilter(c)
    return c:IsFacedown() and c:IsAbleToDeck()
end
function c50218315.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsOnField() and c50218315.tdfilter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(c50218315.tdfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
    local g=Duel.SelectTarget(tp,c50218315.tdfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
    Duel.SetChainLimit(c50218315.limit(g:GetFirst()))
end
function c50218315.tdop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
    end
end
function c50218315.limit(c)
    return  function (e,lp,tp)
                return e:GetHandler()~=c
            end
end
function c50218315.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c50218315.drop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Draw(p,d,REASON_EFFECT)
end