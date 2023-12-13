local isTaz = false

Citizen.CreateThread(function()
	StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
    for i = 1, 16 do
        EnableDispatchService(i, false)
        Citizen.Wait(0)
    end
    AddTextEntry('FE_THDR_GTAO', 'Spaceman Roleplay Indonesia')
    AddTextEntry('PM_PANE_CFX', '#SMRP Keybind')

    --

    DisableIdleCamera(true)

	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)

    -- Disable Ambient Cop Sirens
    DistantCopCarSirens(false)
    -- Make the World Limit HUGE!
    ExpandWorldLimits(-9000.0, -11000.0, 30.0)
    ExpandWorldLimits(10000.0, 12000.0, 30.0)

	while true do
		Citizen.Wait(0)

		SetWeaponDamageModifierThisFrame(`WEAPON_UNARMED`, 0.5)
		SetWeaponDamageModifierThisFrame(`WEAPON_MACHETE`, 0.5)
		SetWeaponDamageModifierThisFrame(`WEAPON_FLASHLIGHT`, 0.5)
		SetWeaponDamageModifierThisFrame(`WEAPON_WRENCH`, 0.5)
		SetWeaponDamageModifierThisFrame(`WEAPON_BAT`, 0.5)
		SetWeaponDamageModifierThisFrame(`WEAPON_KNIFE`, 0.5)
		SetWeaponDamageModifierThisFrame(`WEAPON_NIGHTSTICK`, 0.5)
        SetWeaponDamageModifierThisFrame(`WEAPON_MUSKET`, 0.05)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		
		if IsPedBeingStunned(playerPed) and not isTaz then
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
			SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
		elseif not IsPedBeingStunned(playerPed) and isTaz then
			isTaz = false
			Citizen.Wait(5000)
			SetTimecycleModifier("hud_def_desat_Trevor")
			Citizen.Wait(10000)
      		SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
	end
end)

Citizen.CreateThread(function()
    -- Other stuff normally here, stripped for the sake of only scenario stuff
    local SCENARIO_TYPES = {
        "WORLD_HUMAN_AA_COFFEE",
        "WORLD_HUMAN_AA_SMOKE",
        "WORLD_HUMAN_BINOCULARS",
        "WORLD_HUMAN_BUM_FREEWAY",
        "WORLD_HUMAN_BUM_SLUMPED",
        "WORLD_HUMAN_BUM_STANDING",
        "WORLD_HUMAN_BUM_WASH",
        "WORLD_HUMAN_CAR_PARK_ATTENDANT",
        "WORLD_HUMAN_CHEERING",
        "WORLD_HUMAN_CLIPBOARD",
        "WORLD_HUMAN_CONST_DRILL",
        "WORLD_HUMAN_COP_IDLES",
        "WORLD_HUMAN_DRINKING",
        "WORLD_HUMAN_DRUG_DEALER",
        "WORLD_HUMAN_DRUG_DEALER_HARD",
        "WORLD_HUMAN_MOBILE_FILM_SHOCKING",
        "WORLD_HUMAN_GARDENER_LEAF_BLOWER",
        "WORLD_HUMAN_GARDENER_PLANT",
        "WORLD_HUMAN_GOLF_PLAYER",
        "WORLD_HUMAN_GUARD_PATROL",
        "WORLD_HUMAN_GUARD_STAND",
        "WORLD_HUMAN_GUARD_STAND_ARMY",
        "WORLD_HUMAN_HAMMERING",
        "WORLD_HUMAN_HANG_OUT_STREET",
        "WORLD_HUMAN_HIKER",
        "WORLD_HUMAN_HIKER_STANDING",
        "WORLD_HUMAN_HUMAN_STATUE",
        "WORLD_HUMAN_JANITOR",
        "WORLD_HUMAN_JOG",
        "WORLD_HUMAN_JOG_STANDING",
        "WORLD_HUMAN_LEANING",
        "WORLD_HUMAN_MAID_CLEAN",
        "WORLD_HUMAN_MUSCLE_FLEX",
        "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS",
        "WORLD_HUMAN_MUSICIAN",
        "WORLD_HUMAN_PAPARAZZI",
        "WORLD_HUMAN_PARTYING",
        "WORLD_HUMAN_PICNIC",
        "WORLD_HUMAN_POWER_WALKER",
        "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS",
        "WORLD_HUMAN_PROSTITUTE_LOW_CLASS",
        "WORLD_HUMAN_PUSH_UPS",
        "WORLD_HUMAN_SEAT_LEDGE",
        "WORLD_HUMAN_SEAT_LEDGE_EATING",
        "WORLD_HUMAN_SEAT_STEPS",
        "WORLD_HUMAN_SEAT_WALL",
        "WORLD_HUMAN_SEAT_WALL_EATING",
        "WORLD_HUMAN_SEAT_WALL_TABLET",
        "WORLD_HUMAN_SECURITY_SHINE_TORCH",
        "WORLD_HUMAN_SIT_UPS",
        "WORLD_HUMAN_SMOKING",
        "WORLD_HUMAN_SMOKING_POT",
        "WORLD_HUMAN_STAND_FIRE",
        "WORLD_HUMAN_STAND_FISHING",
        "WORLD_HUMAN_STAND_IMPATIENT",
        "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT",
        "WORLD_HUMAN_STAND_MOBILE",
        "WORLD_HUMAN_STAND_MOBILE_UPRIGHT",
        "WORLD_HUMAN_STRIP_WATCH_STAND",
        "WORLD_HUMAN_STUPOR",
        "WORLD_HUMAN_SUNBATHE",
        "WORLD_HUMAN_SUNBATHE_BACK",
        "WORLD_HUMAN_SUPERHERO",
        "WORLD_HUMAN_SWIMMING",
        "WORLD_HUMAN_TENNIS_PLAYER",
        "WORLD_HUMAN_TOURIST_MAP",
        "WORLD_HUMAN_TOURIST_MOBILE",
        "WORLD_HUMAN_VEHICLE_MECHANIC",
        "WORLD_HUMAN_WELDING",
        "WORLD_HUMAN_WINDOW_SHOP_BROWSE",
        "WORLD_HUMAN_YOGA",
        "Walk",
        "DRIVE",
        "WORLD_VEHICLE_ATTRACTOR",
        "PARK_VEHICLE",
        "WORLD_VEHICLE_AMBULANCE",
        "WORLD_VEHICLE_BICYCLE_BMX",
        "WORLD_VEHICLE_BICYCLE_BMX_BALLAS",
        "WORLD_VEHICLE_BICYCLE_BMX_FAMILY",
        "WORLD_VEHICLE_BICYCLE_BMX_HARMONY",
        "WORLD_VEHICLE_BICYCLE_BMX_VAGOS",
        "WORLD_VEHICLE_BICYCLE_MOUNTAIN",
        "WORLD_VEHICLE_BICYCLE_ROAD",
        "WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",
        "WORLD_VEHICLE_BIKER",
        "WORLD_VEHICLE_BOAT_IDLE",
        "WORLD_VEHICLE_BOAT_IDLE_ALAMO",
        "WORLD_VEHICLE_BOAT_IDLE_MARQUIS",
        "WORLD_VEHICLE_BROKEN_DOWN",
        "WORLD_VEHICLE_BUSINESSMEN",
        "WORLD_VEHICLE_HELI_LIFEGUARD",
        "WORLD_VEHICLE_CLUCKIN_BELL_TRAILER",
        "WORLD_VEHICLE_CONSTRUCTION_SOLO",
        "WORLD_VEHICLE_CONSTRUCTION_PASSENGERS",
        "WORLD_VEHICLE_DRIVE_PASSENGERS",
        "WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED",
        "WORLD_VEHICLE_DRIVE_SOLO",
        "WORLD_VEHICLE_FARM_WORKER",
        "WORLD_VEHICLE_FIRE_TRUCK",
        "WORLD_VEHICLE_EMPTY",
        "WORLD_VEHICLE_MARIACHI",
        "WORLD_VEHICLE_MECHANIC",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_PARK_PARALLEL",
        "WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN",
        "WORLD_VEHICLE_PASSENGER_EXIT",
        "WORLD_VEHICLE_POLICE_BIKE",
        "WORLD_VEHICLE_POLICE_CAR",
        "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
        "WORLD_VEHICLE_QUARRY",
        "WORLD_VEHICLE_SALTON",
        "WORLD_VEHICLE_SALTON_DIRT_BIKE",
        "WORLD_VEHICLE_SECURITY_CAR",
        "WORLD_VEHICLE_STREETRACE",
        "WORLD_VEHICLE_TOURBUS",
        "WORLD_VEHICLE_TOURIST",
        "WORLD_VEHICLE_TANDL",
        "WORLD_VEHICLE_TRACTOR",
        "WORLD_VEHICLE_TRACTOR_BEACH",
        "WORLD_VEHICLE_TRUCK_LOGS",
        "WORLD_VEHICLE_TRUCKS_TRAILERS",
        "PROP_BIRD_IN_TREE",
        "WORLD_VEHICLE_DISTANT_EMPTY_GROUND",
        "PROP_BIRD_TELEGRAPH_POLE",
        "PROP_HUMAN_ATM",
        "PROP_HUMAN_BBQ",
        "PROP_HUMAN_BUM_BIN",
        "PROP_HUMAN_BUM_SHOPPING_CART",
        "PROP_HUMAN_MUSCLE_CHIN_UPS",
        "PROP_HUMAN_MUSCLE_CHIN_UPS_ARMY",
        "PROP_HUMAN_MUSCLE_CHIN_UPS_PRISON",
        "PROP_HUMAN_PARKING_METER",
        "PROP_HUMAN_SEAT_ARMCHAIR",
        "PROP_HUMAN_SEAT_BAR",
        "PROP_HUMAN_SEAT_BENCH",
        "PROP_HUMAN_SEAT_BENCH_DRINK",
        "PROP_HUMAN_SEAT_BENCH_DRINK_BEER",
        "PROP_HUMAN_SEAT_BENCH_FOOD",
        "PROP_HUMAN_SEAT_BUS_STOP_WAIT",
        "PROP_HUMAN_SEAT_CHAIR",
        "PROP_HUMAN_SEAT_CHAIR_DRINK",
        "PROP_HUMAN_SEAT_CHAIR_DRINK_BEER",
        "PROP_HUMAN_SEAT_CHAIR_FOOD",
        "PROP_HUMAN_SEAT_CHAIR_UPRIGHT",
        "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER",
        "PROP_HUMAN_SEAT_COMPUTER",
        "PROP_HUMAN_SEAT_DECKCHAIR",
        "PROP_HUMAN_SEAT_DECKCHAIR_DRINK",
        "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS",
        "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS_PRISON",
        "PROP_HUMAN_SEAT_SEWING",
        "PROP_HUMAN_SEAT_STRIP_WATCH",
        "PROP_HUMAN_SEAT_SUNLOUNGER",
        "PROP_HUMAN_STAND_IMPATIENT",
        "CODE_HUMAN_COWER",
        "CODE_HUMAN_CROSS_ROAD_WAIT",
        "CODE_HUMAN_PARK_CAR",
        "PROP_HUMAN_MOVIE_BULB",
        "PROP_HUMAN_MOVIE_STUDIO_LIGHT",
        "CODE_HUMAN_MEDIC_KNEEL",
        "CODE_HUMAN_MEDIC_TEND_TO_DEAD",
        "CODE_HUMAN_MEDIC_TIME_OF_DEATH",
        "CODE_HUMAN_POLICE_CROWD_CONTROL",
        "CODE_HUMAN_POLICE_INVESTIGATE",
        "CHAINING_ENTRY",
        "CHAINING_EXIT",
        "CODE_HUMAN_STAND_COWER",
        "EAR_TO_TEXT",
        "EAR_TO_TEXT_FAT",
        "WORLD_LOOKAT_POINT",
    }
    local SCENARIO_GROUPS = {
        2017590552, -- LSIA planes
        2141866469, -- Sandy Shores planes
        1409640232, -- Grapeseed planes
        "ng_planes", -- Far up in the skies jets
    }
    local SUPPRESSED_MODELS = {
        "SHAMAL", -- They spawn on LSIA and try to take off
        "LUXOR", -- They spawn on LSIA and try to take off
        "LUXOR2", -- They spawn on LSIA and try to take off
        "JET", -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
        "LAZER", -- They spawn on Zancudo and try to take off
        "TITAN", -- They spawn on Zancudo and try to take off
        "BARRACKS", -- Regularily driving around the Zancudo airport surface
        "BARRACKS2", -- Regularily driving around the Zancudo airport surface
        "CRUSADER", -- Regularily driving around the Zancudo airport surface
        "RHINO", -- Regularily driving around the Zancudo airport surface
        "AIRTUG", -- Regularily spawns on the LSsIA airport surface
        "RIPLEY", -- Regularily spawns on the LSIA airport surface
		"TAXI",
        "PHANTOM",
        "HAULER",
        "RUBBLE",
        "BIFF",
        "TACO",
        "PACKER",
        "TRAILERS",
        "TRAILERS2",
        "TRAILERS3",
        "TRAILERS4",
    }

    while true do
        for _, sctyp in next, SCENARIO_TYPES do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, SCENARIO_GROUPS do
            SetScenarioGroupEnabled(scgrp, false)
        end
        for _, model in next, SUPPRESSED_MODELS do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end
        Wait(10000)
    end
end)