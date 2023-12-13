local scopedWeapons = 
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282, -- WEAPON_MARKSMANRIFLE
	177293209,   -- WEAPON_HEAVYSNIPER MKII
	1785463520  -- WEAPON_MARKSMANRIFLE_MK2
}

function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 

    return false 
end 

function ManageReticle()
    local ped = GetPlayerPed( -1 )
    local _, hash = GetCurrentPedWeapon( ped, true )
        if not HashInTable( hash ) then 
            HideHudComponentThisFrame( 14 )
		end 
end 

local recoils = {
	[4153432689] = 0.0, -- PISTOL
}

local brutalreco = {
	[-619010992] = 0.01, -- TEC9
	[584646201] = 0.01, --AP
	[-2084633992] = 0.01, --CRB
}

CreateThread(function()
	while true do
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)
		--print(weapon) -- To get the weapon hash by pressing F8 in game

		ManageReticle()

		local waktupegangsenjata = 1000
		
		-- Pistol
		if weapon == GetHashKey("WEAPON_STUNGUN") then
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
			end
		end
		
		if weapon == GetHashKey("WEAPON_FLAREGUN") then
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SNSPISTOL") then	
			waktupegangsenjata = 1	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SNSPISTOL_MK2") then	
			waktupegangsenjata = 1	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL") then		
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL_MK2") then
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.11)
			end
		end
		
		if weapon == GetHashKey("WEAPON_APPISTOL") then
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.10)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATPISTOL") then		
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.10)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL50") then
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.11)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYPISTOL") then	
			waktupegangsenjata = 1	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
			end
		end
		
		if weapon == GetHashKey("WEAPON_VINTAGEPISTOL") then
			waktupegangsenjata = 1		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MARKSMANPISTOL") then		
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.03)
			end
		end
		
		if weapon == GetHashKey("WEAPON_REVOLVER") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.55)
			end
		end
		
		if weapon == GetHashKey("WEAPON_REVOLVER_MK2") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.61)
			end
		end
		
		if weapon == GetHashKey("WEAPON_DOUBLEACTION") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.37)
			end
		end
		-- SMG
		
		if weapon == GetHashKey("WEAPON_MICROSMG") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATPDW") then	
			waktupegangsenjata = 1		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SMG") then
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SMG_MK2") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ASSAULTSMG") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MACHINEPISTOL") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MINISMG") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.10)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MG") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATMG") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATMG_MK2") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0)
			end
		end
		
		-- Rifles
		
		if weapon == GetHashKey("WEAPON_ASSAULTRIFLE") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0)
			end
		end
		
		if weapon == GetHashKey("WEAPON_CARBINERIFLE") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0)
			end
		end
		
		if weapon == GetHashKey("WEAPON_CARBINERIFLE_MK2") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ADVANCEDRIFLE") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.020)
			end
		end
		
		if weapon == GetHashKey("WEAPON_GUSENBERG") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SPECIALCARBINE") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0)
			end
		end
		
		if weapon == GetHashKey("WEAPON_BULLPUPRIFLE") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end
		
		if weapon == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end

		if weapon == GetHashKey("WEAPON_TACTICALRIFLE") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMPACTRIFLE") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.030)
			end
		end
		
		-- Shotgun
		
		if weapon == GetHashKey("WEAPON_PUMPSHOTGUN") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.085)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ASSAULTSHOTGUN") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.12)
			end
		end
		
		if weapon == GetHashKey("WEAPON_BULLPUPSHOTGUN") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end
		
		if weapon == GetHashKey("WEAPON_DBSHOTGUN") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		if weapon == GetHashKey("WEAPON_AUTOSHOTGUN") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MUSKET") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.04)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYSHOTGUN") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.13)
			end
		end
		
		-- Sniper
		
		if weapon == GetHashKey("WEAPON_SNIPERRIFLE") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYSNIPER") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.55)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYSNIPER_MK2") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.55)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MARKSMANRIFLE") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MARKSMANRIFLE_MK2") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)
			end
		end
		
		-- Launcher
		
		if weapon == GetHashKey("WEAPON_GRENADELAUNCHER") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end
		
		if weapon == GetHashKey("WEAPON_RPG") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.9)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HOMINGLAUNCHER") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.9)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MINIGUN") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.20)
			end
		end
		
		if weapon == GetHashKey("WEAPON_RAILGUN") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.0)
				
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMPACTLAUNCHER") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end
		
		if weapon == GetHashKey("WEAPON_FIREWORK") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.5)
			end
		end

		if weapon == GetHashKey("WEAPON_NAVYREVOLVER") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.65)
			end
		end
		
		-- Infinite FireExtinguisher
		
		if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then	
			waktupegangsenjata = 1
			if IsPedShooting(ped) then
				SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
			end
		end

		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			waktupegangsenjata = 1
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if recoils[wep] and recoils[wep] ~= 4 then
				tv = 0
				repeat 
					Wait(0)
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 6 then
						SetGameplayCamRelativePitch(p+4.5, 0.6)
					end
					tv = tv+1.0
				until tv >= recoils[wep]
			end
			local _X,wepX = GetCurrentPedWeapon(PlayerPedId())
			_X,cAmmoX = GetAmmoInClip(PlayerPedId(), wepX)
			if brutalreco[wepX] and brutalreco[wepX] ~= 4 then
				tvX = 0
				repeat 
					Wait(0)
					pX = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 6 then
						SetGameplayCamRelativePitch(pX+0.1, 0.1)
					end
					tvX = tvX+0.1
				until tvX >= brutalreco[wepX]
			end
		end
		Wait(waktupegangsenjata)
	end
end)