-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

Config = {}

Config.PaymentAccount = 'money' -- Payment account you want to pay from(For example; 'money', 'bank', 'black_money')

Config.ClothingShops = {

	{
		blip = {
			enabled = true, -- Blip enabled?
			sprite = 73, -- The Blip type. List: https://docs.fivem.net/docs/game-references/blips/#blips
			color = 47, -- The Blip color. List: https://docs.fivem.net/docs/game-references/blips/#blip-colors
			scale = 0.7, -- Size of blip
			string = 'Clothing Shop'
		},
		coords = vec3(72.3, -1399.1, 28.4), -- Coords of shop
		distance = 3, -- Distance to show text UI pormpt
		price = 15000, -- Price to use this shop(False for free)
	},
	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-708.7, -152.1, 36.4),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-165.1, -302.4, 38.6),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(428.7, -800.1, 28.5),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-829.4, -1073.7, 10.3),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-1449.1, -238.3, 48.8),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(11.6, 6514.2, 30.9),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(122.9, -222.2, 53.5),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(1696.3, 4829.3, 41.1),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(618.1, 2759.6, 41.1),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(1190.6, 2713.4, 37.2),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-1193.4, -772.3, 16.3),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-3172.5, 1048.1, 19.9),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = true, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-1108.4, 2708.9, 18.1),
		distance = 3, 
		price = 15000, 
	},

	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(301.7932, -599.2435, 43.2840), -- Pillbox Hospital
		distance = 3, 
		price = false, 
	},

	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(451.8551, -993.3729, 30.6895), -- MRPD Cloakroom
		distance = 3, 
		price = false, 
	},

	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-1622.6, -1034.0, 13.1), -- Beach
		distance = 3, 
		price = 250, 
	},

	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-339.5738, -161.4994, 44.5875), -- Bengkel
		distance = 1, 
		price = false, 
	},

	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-1838.7224, -1187.0118, 14.3092), -- Pearls
		distance = 2, 
		price = false, 
	},

	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(1742.1, 2481.5, 45.7), -- Prison
		distance = 7, 
		price = false, 
	},

	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(516.8, 4823.5, -66.1), -- Submarine interior
		distance = 7, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(83.1583, -1956.7847, 25.4856), -- 13th Hooligans
		distance = 3, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-63.8520, 842.5543, 235.7290), -- Neverdie
		distance = 3, 
		price = false, 
	},

	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(1374.0424, -2111.2412, 47.2081), -- Sinners212
		distance = 3, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(357.7614, -2033.0482, 22.3950), -- The Dosmon
		distance = 1.5, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-2619.3047, 1711.3778, 146.3226), -- Rumah bang james
		distance = 3, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-1887.0580, 2070.4333, 145.5737), -- EL NATANIELIE FAMILIA
		distance = 3, 
		price = false, 
	},

	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(2510.4150, 4091.3560, 35.5852), -- SOA
		distance = 3, 
		price = false, 
	},
	
		{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(3305.2405, 5183.0659, 19.7174), -- Revenge
		distance = 3, 
		price = false, 
	},
	
			{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(1370.7634, -547.3239, 74.6879), -- Perumnas 4
		distance = 2, 
		price = false, 
	},
	
			{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-671.4161, 587.1064, 141.5699), -- Rumahstz
		distance = 2, 
		price = false, 
	},
	
			{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-797.5933, 328.4906, 190.7159), -- Apartment  Dchoo
		distance = 2, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-3218.7681, 784.2131, 14.0897), -- Rumah Dika
		distance = 2, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-1467.7489, -45.2206, 58.6683), -- Rumah Matthew
		distance = 2, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-1234.7703, 796.9436, 197.2050), -- Rumah Arsha
		distance = 2, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(1005.3103, -121.9891, 74.0703), -- ExBerabe
		distance = 2, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(948.6381, -672.8586, 61.5457), -- Rumah Asahie2
		distance = 2, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(904.6696, -477.6172, 62.5298), -- Rumah RobertNiko
		distance = 2, 
		price = false, 
	},
	
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(8.9357, 528.3842, 170.6350), -- Rumah Revenge
		distance = 2, 
		price = false, 
	},
	
	
 --CASINO
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(-307.1001, 214.1220, 145.3193),
		distance = 2, 
		price = false,  
	},

--ALDI
	{
		blip = {
			enabled = false, 
			sprite = 73, 
			color = 47, 
			scale = 0.7, 
			string = 'Clothing Shop'
		},
		coords = vec3(180.5918, 1715.6260, 231.4921),
		distance = 2, 
		price = false,
	},
	
	
	
}

Config.BarberShops = {

	{
		blip = {
			enabled = true, -- Blip enabled?
			sprite = 71, -- The Blip type. List: https://docs.fivem.net/docs/game-references/blips/#blips
			color = 47, -- The Blip color. List: https://docs.fivem.net/docs/game-references/blips/#blip-colors
			scale = 0.7, -- Size of blip
			string = 'Barber Shop'
		},
		coords = vec3(-814.3, -183.8, 36.6), -- Coords of shop
		distance = 7, -- Distance to show text UI pormpt
		price = 50, -- Price to use this shop(False for free)
	},

	{
		blip = {
			enabled = true,
			sprite = 71, 
			color = 47, 
			scale = 0.7,
			string = 'Barber Shop'
		},
		coords = vec3(136.8, -1708.4, 28.3), 
		distance = 7,
		price = 50,
	},

	{
		blip = {
			enabled = true,
			sprite = 71, 
			color = 47, 
			scale = 0.7,
			string = 'Barber Shop'
		},
		coords = vec3(-1282.6, -1116.8, 6.0), 
		distance = 7,
		price = 50,
	},

	{
		blip = {
			enabled = true,
			sprite = 71, 
			color = 47, 
			scale = 0.7,
			string = 'Barber Shop'
		},
		coords = vec3(1931.5, 3729.7, 31.8), 
		distance = 7,
		price = 50,
	},

	{
		blip = {
			enabled = true,
			sprite = 71, 
			color = 47, 
			scale = 0.7,
			string = 'Barber Shop'
		},
		coords = vec3(1212.8, -472.9, 65.2), 
		distance = 7,
		price = 50,
	},

	{
		blip = {
			enabled = true,
			sprite = 71, 
			color = 47, 
			scale = 0.7,
			string = 'Barber Shop'
		},
		coords = vec3(-34.31, -154.99, 55.8), 
		distance = 7,
		price = 50,
	},

	{
		blip = {
			enabled = true,
			sprite = 71, 
			color = 47, 
			scale = 0.7,
			string = 'Barber Shop'
		},
		coords = vec3(-278.1, 6228.5, 30.7), 
		distance = 7,
		price = 50,
	},

}

Config.TattooShops = {

	{
		blip = {
			enabled = true,
			sprite = 75, 
			color = 1, 
			scale = 0.7,
			string = 'Tattoo Shop'
		},
		coords = vec3(1322.6, -1651.9, 51.2), 
		distance = 7,
		price = 350,
	},

	{
		blip = {
			enabled = true,
			sprite = 75, 
			color = 1, 
			scale = 0.7,
			string = 'Tattoo Shop'
		},
		coords = vec3(-1153.6, -1425.6, 4.9), 
		distance = 7,
		price = 350,
	},

	{
		blip = {
			enabled = true,
			sprite = 75, 
			color = 1, 
			scale = 0.7,
			string = 'Tattoo Shop'
		},
		coords = vec3(322.1, 180.4, 103.5), 
		distance = 7,
		price = 350,
	},

	{
		blip = {
			enabled = true,
			sprite = 75, 
			color = 1, 
			scale = 0.7,
			string = 'Tattoo Shop'
		},
		coords = vec3(-3170.0, 1075.0, 20.8), 
		distance = 7,
		price = 350,
	},

	{
		blip = {
			enabled = true,
			sprite = 75, 
			color = 1, 
			scale = 0.7,
			string = 'Tattoo Shop'
		},
		coords = vec3(1864.6, 3747.7, 33.0), 
		distance = 7,
		price = 350,
	},

	{
		blip = {
			enabled = true,
			sprite = 75, 
			color = 1, 
			scale = 0.7,
			string = 'Tattoo Shop'
		},
		coords = vec3(-293.7, 6200.0, 31.4), 
		distance = 7,
		price = 350,
	},

}
--=========================================================
--		SOLUTION FOR INVISIBLE PLAYER
--=========================================================

Config.DefaultSkin = {
	["headOverlays"]={
		["eyebrows"]={["style"]=0,["color"]=0,["opacity"]=0},
		["makeUp"]={["style"]=0,["color"]=0,["opacity"]=0},
		["bodyBlemishes"]={["style"]=0,["color"]=0,["opacity"]=0},
		["blush"]={["style"]=0,["color"]=0,["opacity"]=0},
		["ageing"]={["style"]=0,["color"]=0,["opacity"]=0},
		["beard"]={["style"]=0,["color"]=0,["opacity"]=0},
		["moleAndFreckles"]={["style"]=0,["color"]=0,["opacity"]=0},
		["blemishes"]={["style"]=0,["color"]=0,["opacity"]=0},
		["chestHair"]={["style"]=0,["color"]=0,["opacity"]=0},
		["lipstick"]={["style"]=0,["color"]=0,["opacity"]=0},
		["sunDamage"]={["style"]=0,["color"]=0,["opacity"]=0},
		["complexion"]={["style"]=0,["color"]=0,["opacity"]=0}
	},
	["faceFeatures"]={
		["jawBoneWidth"]=0,
		["chinBoneLowering"]=0,
		["eyesOpening"]=0,
		["eyeBrownHigh"]=0,
		["jawBoneBackSize"]=0,
		["cheeksBoneHigh"]=0,
		["eyeBrownForward"]=0,
		["nosePeakHigh"]=0,
		["neckThickness"]=0,
		["nosePeakLowering"]=0,
		["chinBoneLenght"]=0,
		["noseWidth"]=0,
		["noseBoneHigh"]=0,
		["chinBoneSize"]=0,
		["nosePeakSize"]=0,
		["cheeksBoneWidth"]=0,
		["noseBoneTwist"]=0,
		["chinHole"]=0,
		["cheeksWidth"]=0,
		["lipsThickness"]=0
	},
	["headBlend"]={
		["shapeMix"]=0,
		["shapeSecond"]=0,
		["skinSecond"]=0,
		["shapeFirst"]=0,
		["skinMix"]=0,
		["skinFirst"]=0
	},
	["components"]={
		{["drawable"]=0,["texture"]=0,["component_id"]=0},
		{["drawable"]=0,["texture"]=0,["component_id"]=1},
		{["drawable"]=0,["texture"]=0,["component_id"]=2},
		{["drawable"]=0,["texture"]=0,["component_id"]=3},
		{["drawable"]=0,["texture"]=0,["component_id"]=4},
		{["drawable"]=0,["texture"]=0,["component_id"]=5},
		{["drawable"]=0,["texture"]=0,["component_id"]=6},
		{["drawable"]=0,["texture"]=0,["component_id"]=7},
		{["drawable"]=0,["texture"]=0,["component_id"]=8},
		{["drawable"]=0,["texture"]=0,["component_id"]=9},
		{["drawable"]=0,["texture"]=0,["component_id"]=10},
		{["drawable"]=0,["texture"]=0,["component_id"]=11}
	},
	["props"]={
		{["drawable"]=-1,["prop_id"]=1,["texture"]=-1},
		{["drawable"]=-1,["prop_id"]=2,["texture"]=-1},
		{["drawable"]=-1,["prop_id"]=6,["texture"]=-1},
		{["drawable"]=-1,["prop_id"]=7,["texture"]=-1},
		{["drawable"]=-1,["prop_id"]=0,["texture"]=-1}
	},
	["hair"]={
		["style"]=0,
		["highlight"]=0,
		["color"]=0
	},
	["tattoos"]={},
	["eyeColor"]=-1,
	["model"]="mp_m_freemode_01"
}
