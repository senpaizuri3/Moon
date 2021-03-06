--太陽電池メン
--Solar Batteryman
--Scripted by Eerie Code
function c101004027.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101004027,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,101004027)
	e1:SetTarget(c101004027.tgtg)
	e1:SetOperation(c101004027.tgop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--token
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(101004027,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCountLimit(1,101004027+100)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c101004027.tkcon)
	e3:SetTarget(c101004027.tktg)
	e3:SetOperation(c101004027.tkop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--name
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(101004027,2))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCountLimit(1,101004027+200)
	e5:SetTarget(c101004027.nmtg)
	e5:SetOperation(c101004027.nmop)
	c:RegisterEffect(e5)
end
function c101004027.tgfilter(c)
	return c:IsRace(RACE_THUNDER) and c:IsAbleToGrave()
end
function c101004027.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c101004027.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c101004027.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c101004027.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c101004027.tkcfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_THUNDER)
end
function c101004027.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c101004027.tkcfilter,1,nil) and not eg:IsContains(e:GetHandler())
end
function c101004027.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c101004027.tkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,101004027+100,0,0x4011,0,0,1,RACE_THUNDER,ATTRIBUTE_LIGHT) then return end
	local token=Duel.CreateToken(tp,101004027+100)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end
function c101004027.nmfilter(c,cd)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsType(TYPE_EFFECT)
		and c:IsOriginalSetCard(0x28) and c:GetOriginalCode()~=cd
end
function c101004027.nmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cd=e:GetHandler():GetCode()
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsControler(tp) and c101004027.nmfilter(chkc,cd) end
	if chk==0 then return Duel.IsExistingTarget(c101004027.nmfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil,cd) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c101004027.nmfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil,cd)
end
function c101004027.nmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and (tc:IsLocation(LOCATION_GRAVE) or tc:IsFaceup()) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(tc:GetOriginalCode())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
