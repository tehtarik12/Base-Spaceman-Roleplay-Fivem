local show3DText = true

RegisterNetEvent("pixel_anticl")
AddEventHandler("pixel_anticl", function(id, crds, identifier, reason)
    Display(id, crds, identifier, reason)
end)

function Display(id, crds, identifier, reason)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(20*1000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        while displaying do
            Wait(5)
            local pcoords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(crds.x, crds.y, crds.z, pcoords.x, pcoords.y, pcoords.z, true) < 15.0 and show3DText then
                DrawText3DSecondSS(crds.x, crds.y, crds.z+0.15, "Player Left Game")
                DrawText3DSS(crds.x, crds.y, crds.z, "ID: "..id.." ("..identifier..")\nReason: "..reason)
            else
                Citizen.Wait(2000)
            end
        end
    end)
end

function DrawText3DSecondSS(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 0, 0, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function DrawText3DSS(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end