local sc0tt_driveby = {}
sc0tt_driveby['driveby'] = true -- can anybody shoot?
sc0tt_driveby['driver'] = false  -- can driver shoot?
sc0tt_driveby['rear'] = false -- can shoot behind?
sc0tt_driveby['dist'] = -8.0 -- how far behind the ped is the cut off point? (the closer it is, the less backwards they will be able to shoot)

-- stop shooting behind you fucks
function lookingBehind()
	local coordA = GetEntityCoords(PlayerPedId(), 1)
	local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, sc0tt_driveby.dist, 0.0)
    --DrawMarker(1,coordB,0,0,0,0,0,0,1.001,1.0001,0.4001,0,155,255,175,0,0,0,0)
    local onScreen,_x,_y=World3dToScreen2d(coordB.x,coordB.y,coordB.z)
   	return onScreen
end

Citizen.CreateThread(function()
	while true do
		local letsleep = 2000
		if IsPedInAnyVehicle(PlayerPedId()) then
			letsleep = 0
			local canshoot = true
			if sc0tt_driveby.driver == false then
				local veh = GetVehiclePedIsIn(PlayerPedId(),false)
				if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
					canshoot = false -- no shooty shooty driver
				end
			end
			if sc0tt_driveby.driveby == false then
				canshoot = false -- no shooty shooty ever
			end
			if canshoot and not sc0tt_driveby.rear then
				canshoot = not lookingBehind()
			end

			SetPlayerCanDoDriveBy(PlayerId(), canshoot)
		end

		Citizen.Wait(letsleep)
	end
end)