local havebike = false

Citizen.CreateThread(function()
    while true do
		local letsleep = 1000
		local ped = PlayerPedId()
		local pedcoords = GetEntityCoords(ped, false)

		if IsPedOnFoot(ped) then
			for k, v in pairs(Config.MarkerZonesSepeda) do
				local Pos = vector3(v.x, v.y, v.z)
				if(#(pedcoords - Pos) < 20) then
					letsleep = 0
					DrawMarker(1, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.300, 0, 0, 255, 200, 0, 0, 0, 0)
				end	
			end
		end
		Citizen.Wait(letsleep)
    end
end)

Citizen.CreateThread(function()
    while true do
		local letsleep = 1000
		local ped = PlayerPedId()
		local pedcoords = GetEntityCoords(ped, false)
        for k, v in pairs(Config.MarkerZonesSepeda) do
			local Pos = vector3(v.x, v.y, v.z)
			if(#(pedcoords - Pos) < 2) then
				if havebike == false and IsPedOnFoot(ped) then
					letsleep = 0
					ESX.ShowHelpNotification('Press E To Open bike menu')

					if IsControlJustPressed(0, 38) then
						
						OpenBikesMenu()
					end 
				elseif havebike == true and IsPedOnAnyBike(ped) then
					letsleep = 0
					ESX.ShowHelpNotification('Store Biker')
					
					if IsControlJustPressed(0, 38) then
						TriggerEvent('esx:deleteVehicle')
						havebike = false
					end 		
				end
			elseif(#(pedcoords - Pos) < 1.75) then
				ESX.UI.Menu.CloseAll()
            end
        end
		Citizen.Wait(letsleep)
    end
end)

function OpenBikesMenu()
	local elements = Config.BikeList

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'client', {
		title    = 'Bike Rental',
		align    = 'bottom-right',
		elements = elements,
    }, function(data, menu)
		ESX.ShowNotification('You rent bike for ' .. data.current.price)
		TriggerServerEvent("esx:bike:lowmoney", data.current.price)
		spawn_effect(data.current.value)

		ESX.UI.Menu.CloseAll()
		havebike = true	
    end, function(data, menu)
		menu.close()
	end)
end

function spawn_effect(somecar) 
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	TriggerEvent('esx:spawnVehicle', somecar)
	DoScreenFadeIn(3000) 
end