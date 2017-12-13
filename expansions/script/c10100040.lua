--Stygische Basis
function c10100040.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Remove
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c10100040.target)
	e2:SetOperation(c10100040.operation)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e3:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c10100040.rmtarget)
	e3:SetTargetRange(0xff,0xff)
	e3:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(10100040)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e4:SetTargetRange(0xff,0xff)
	e4:SetTarget(c10100040.checktg)
	c:RegisterEffect(e4)
end
function c10100040.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsCode(10100037) and not c:IsCode(10100038) and c:IsSetCard(0x323) or c:IsCode(13521194) or c:IsCode(50732780) and c:IsAbleToRemove()
end
function c10100040.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10100040.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c10100040.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c10100040.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
function c10100040.rmtarget(e,c)
	return not c:IsLocation(0x80) and c:IsSetCard(0x323) or c:IsCode(86137485) or c:IsCode(50732780)
end
function c10100040.checktg(e,c)
	return not c:IsPublic()
end



