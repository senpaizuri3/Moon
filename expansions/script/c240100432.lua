--created & coded by Lyris, art by G.River of Pixiv
--「S・VINE」アストラル・ドラゴン
c240100432.spt_other_space=240100432
function c240100432.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddOrigSpatialType(c)
	aux.AddSpatialProc(c,nil,8,600,nil,aux.TRUE,aux.TRUE)
end
