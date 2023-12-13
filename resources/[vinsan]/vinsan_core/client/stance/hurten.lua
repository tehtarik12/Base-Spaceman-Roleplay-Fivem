local hurten = false

Citizen.CreateThread(function()
	while true do
		Wait(15000)
		if GetEntityHealth(PlayerPedId()) <= 150 and not hurten then
			setHurt()
		elseif GetEntityHealth(PlayerPedId()) > 151 and hurten then
			setNotHurt()
		end
	end
end)

function setHurt()
    hurten = true
	RequestAnimSet("move_m@injured")
	SetPedMovementClipset(PlayerPedId(), "move_m@injured", true)
end

function setNotHurt()
    hurten = false
	TriggerEvent('vinsan_stance:DefaultWalkStyle')
end