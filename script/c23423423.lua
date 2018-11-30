--无敌卡
function c23423423.initial_effect(c)
	 --rec or dam
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c23423423.target)
	e1:SetOperation(c23423423.operation)
	c:RegisterEffect(e1)   
end
function c23423423.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	local op=Duel.SelectOption(tp,aux.Stringid(23423423,0),aux.Stringid(23423423,1),aux.Stringid(23423423,2))
	e:SetLabel(op)
	local pro=0
	if op==0 then
		pro=EFFECT_FLAG_PLAYER_TARGET		
		e:SetCategory(CATEGORY_RECOVER)
		Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(1000)
		Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
	elseif op==1 then
		pro=EFFECT_FLAG_PLAYER_TARGET 
		e:SetCategory(CATEGORY_DAMAGE)
		Duel.SetTargetPlayer(1-tp)
		Duel.SetTargetParam(500)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
	else
		e:SetCategory(CATEGORY_DAMAGE)
		pro=0 
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,500)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
	end
	if Duel.GetLP(tp)-Duel.GetLP(1-tp)>=7000 then
		pro=pro+EFFECT_FLAG_CANNOT_DISABLE 
	end
	if pro then
		e:SetProperty(pro)
	end
	if Duel.GetLP(tp)-Duel.GetLP(1-tp)>=4000 then
		Duel.SetChainLimit(c23423423.chlimit)
	end
end
function c23423423.chlimit(e,ep,tp)
	return tp==ep
end
function c23423423.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Recover(p,d,REASON_EFFECT)
	elseif e:GetLabel()==1 then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Damage(p,d,REASON_EFFECT)
	else
		Duel.Damage(tp,500,REASON_EFFECT)
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end