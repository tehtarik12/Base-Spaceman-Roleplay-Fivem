local islandCoords = vector3(4840.571, -5174.425, 2.0)
local nearIsland = false
local Ipls = {
    "h4_mph4_terrain_occ_09",
    "h4_mph4_terrain_occ_06",
    "h4_mph4_terrain_occ_05",
    "h4_mph4_terrain_occ_01",
    "h4_mph4_terrain_occ_00",
    "h4_mph4_terrain_occ_08",
    "h4_mph4_terrain_occ_04",
    "h4_mph4_terrain_occ_07",
    "h4_mph4_terrain_occ_03",
    "h4_mph4_terrain_occ_02",
    "h4_islandx_terrain_04",
    "h4_islandx_terrain_05_slod",
    "h4_islandx_terrain_props_05_d_slod",
    "h4_islandx_terrain_02",
    "h4_islandx_terrain_props_05_a_lod",
    "h4_islandx_terrain_props_05_c_lod",
    "h4_islandx_terrain_01",
    "h4_mph4_terrain_04",
    "h4_mph4_terrain_06",
    "h4_islandx_terrain_04_lod",
    "h4_islandx_terrain_03_lod",
    "h4_islandx_terrain_props_06_a",
    "h4_islandx_terrain_props_06_a_slod",
    "h4_islandx_terrain_props_05_f_lod",
    "h4_islandx_terrain_props_06_b",
    "h4_islandx_terrain_props_05_b_lod",
    "h4_mph4_terrain_lod",
    "h4_islandx_terrain_props_05_e_lod",
    "h4_islandx_terrain_05_lod",
    "h4_mph4_terrain_02",
    "h4_islandx_terrain_props_05_a",
    "h4_mph4_terrain_01_long_0",
    "h4_islandx_terrain_03",
    "h4_islandx_terrain_props_06_b_slod",
    "h4_islandx_terrain_01_slod",
    "h4_islandx_terrain_04_slod",
    "h4_islandx_terrain_props_05_d_lod",
    "h4_islandx_terrain_props_05_f_slod",
    "h4_islandx_terrain_props_05_c",
    "h4_islandx_terrain_02_lod",
    "h4_islandx_terrain_06_slod",
    "h4_islandx_terrain_props_06_c_slod",
    "h4_islandx_terrain_props_06_c",
    "h4_islandx_terrain_01_lod",
    "h4_mph4_terrain_06_strm_0",
    "h4_islandx_terrain_05",
    "h4_islandx_terrain_props_05_e_slod",
    "h4_islandx_terrain_props_06_c_lod",
    "h4_mph4_terrain_03",
    "h4_islandx_terrain_props_05_f",
    "h4_islandx_terrain_06_lod",
    "h4_mph4_terrain_01",
    "h4_islandx_terrain_06",
    "h4_islandx_terrain_props_06_a_lod",
    "h4_islandx_terrain_props_06_b_lod",
    "h4_islandx_terrain_props_05_b",
    "h4_islandx_terrain_02_slod",
    "h4_islandx_terrain_props_05_e",
    "h4_islandx_terrain_props_05_d",
    "h4_mph4_terrain_05",
    "h4_mph4_terrain_02_grass_2",
    "h4_mph4_terrain_01_grass_1",
    "h4_mph4_terrain_05_grass_0",
    "h4_mph4_terrain_01_grass_0",
    "h4_mph4_terrain_02_grass_1",
    "h4_mph4_terrain_02_grass_0",
    "h4_mph4_terrain_02_grass_3",
    "h4_mph4_terrain_04_grass_0",
    "h4_mph4_terrain_06_grass_0",
    "h4_mph4_terrain_04_grass_1",
    "island_distantlights",
    "island_lodlights",
    "h4_clubposter_moodymann",
    "h4_ch2_mansion_final",
    "h4_mph4_island_placement",
    "h4_islandx_mansion_vault",
    "h4_islandx_checkpoint_props",
    "h4_islandairstrip_hangar_props_slod",
    "h4_se_ipl_01_lod",
    "h4_ne_ipl_00_slod",
    "h4_se_ipl_06_slod",
    "h4_ne_ipl_00",
    "h4_se_ipl_02",
    "h4_islandx_barrack_props_lod",
    "h4_se_ipl_09_lod",
    "h4_ne_ipl_05",
    "h4_mph4_island_se_placement",
    "h4_ne_ipl_09",
    "h4_islandx_mansion_props_slod",
    "h4_se_ipl_09",
    "h4_mph4_mansion_b",
    "h4_islandairstrip_hangar_props_lod",
    "h4_islandx_mansion_entrance_fence",
    "h4_nw_ipl_09",
    "h4_nw_ipl_02_lod",
    "h4_ne_ipl_09_slod",
    "h4_sw_ipl_02",
    "h4_islandx_checkpoint",
    "h4_islandxdock_water_hatch",
    "h4_nw_ipl_04_lod",
    "h4_islandx_maindock_props",
    "h4_beach",
    "h4_islandx_mansion_lockup_03_lod",
    "h4_ne_ipl_04_slod",
    "h4_mph4_island_nw_placement",
    "h4_ne_ipl_08_slod",
    "h4_nw_ipl_09_lod",
    "h4_se_ipl_08_lod",
    "h4_islandx_maindock_props_lod",
    "h4_se_ipl_03",
    "h4_sw_ipl_02_slod",
    "h4_nw_ipl_00",
    "h4_islandx_mansion_b_side_fence",
    "h4_ne_ipl_01_lod",
    "h4_se_ipl_06_lod",
    "h4_ne_ipl_03",
    "h4_islandx_maindock",
    "h4_se_ipl_01",
    "h4_sw_ipl_07",
    "h4_islandx_maindock_props_2",
    "h4_islandxtower_veg",
    "h4_mph4_island_sw_placement",
    "h4_se_ipl_01_slod",
    "h4_mph4_wtowers",
    "h4_se_ipl_02_lod",
    "h4_islandx_mansion",
    "h4_nw_ipl_04",
    "h4_mph4_airstrip_interior_0_airstrip_hanger",
    "h4_islandx_mansion_lockup_01",
    "h4_islandx_barrack_props",
    "h4_nw_ipl_07_lod",
    "h4_nw_ipl_00_slod",
    "h4_sw_ipl_08_lod",
    "h4_islandxdock_props_slod",
    "h4_islandx_mansion_lockup_02",
    "h4_islandx_mansion_slod",
    "h4_sw_ipl_07_lod",
    "h4_sw_ipl_02_lod",
    "h4_se_ipl_04_slod",
    "h4_islandx_checkpoint_props_lod",
    "h4_se_ipl_04",
    "h4_se_ipl_07",
    "h4_mph4_mansion_b_strm_0",
    "h4_nw_ipl_09_slod",
    "h4_se_ipl_07_lod",
    "h4_islandx_maindock_slod",
    "h4_islandx_mansion_lod",
    "h4_sw_ipl_05_lod",
    "h4_nw_ipl_08",
    "h4_islandairstrip_slod",
    "h4_nw_ipl_07",
    "h4_islandairstrip_propsb_lod",
    "h4_islandx_checkpoint_props_slod",
    "h4_aa_guns_lod",
    "h4_sw_ipl_06",
    "h4_islandx_maindock_props_2_slod",
    "h4_islandx_mansion_office",
    "h4_islandx_maindock_lod",
    "h4_mph4_dock",
    "h4_islandairstrip_propsb",
    "h4_islandx_mansion_lockup_03",
    "h4_nw_ipl_01_lod",
    "h4_se_ipl_05_slod",
    "h4_sw_ipl_01_lod",
    "h4_nw_ipl_05",
    "h4_islandxdock_props_2_lod",
    "h4_ne_ipl_04_lod",
    "h4_ne_ipl_01",
    "h4_beach_party_lod",
    "h4_islandx_mansion_lights",
    "h4_sw_ipl_00_lod",
    "h4_islandx_mansion_guardfence",
    "h4_beach_props_party",
    "h4_ne_ipl_03_lod",
    "h4_islandx_mansion_b",
    "h4_beach_bar_props",
    "h4_ne_ipl_04",
    "h4_sw_ipl_08_slod",
    "h4_islandxtower",
    "h4_se_ipl_00_slod",
    "h4_islandx_barrack_hatch",
    "h4_ne_ipl_06_slod",
    "h4_ne_ipl_03_slod",
    "h4_sw_ipl_09_slod",
    "h4_ne_ipl_02_slod",
    "h4_nw_ipl_04_slod",
    "h4_ne_ipl_05_lod",
    "h4_nw_ipl_08_slod",
    "h4_sw_ipl_05_slod",
    "h4_islandx_mansion_b_lod",
    "h4_ne_ipl_08",
    "h4_islandxdock_props",
    "h4_islandairstrip_doorsopen_lod",
    "h4_se_ipl_05_lod",
    "h4_islandxcanal_props_slod",
    "h4_se_ipl_02_slod",
    "h4_nw_ipl_02",
    "h4_ne_ipl_08_lod",
    "h4_sw_ipl_08",
    "h4_islandairstrip",
    "h4_islandairstrip_props_lod",
    "h4_se_ipl_05",
    "h4_ne_ipl_02_lod",
    "h4_islandx_maindock_props_2_lod",
    "h4_sw_ipl_03_slod",
    "h4_ne_ipl_01_slod",
    "h4_beach_props_slod",
    "h4_underwater_gate_closed",
    "h4_ne_ipl_00_lod",
    "h4_islandairstrip_doorsopen",
    "h4_sw_ipl_01_slod",
    "h4_se_ipl_00",
    "h4_se_ipl_06",
    "h4_islandx_mansion_lockup_02_lod",
    "h4_islandxtower_veg_lod",
    "h4_sw_ipl_00",
    "h4_se_ipl_04_lod",
    "h4_nw_ipl_07_slod",
    "h4_islandx_mansion_props_lod",
    "h4_islandairstrip_hangar_props",
    "h4_nw_ipl_06_lod",
    "h4_islandxtower_lod",
    "h4_islandxdock_lod",
    "h4_islandxdock_props_lod",
    "h4_beach_party",
    "h4_nw_ipl_06_slod",
    "h4_nw_ipl_00_lod",
    "h4_ne_ipl_02",
    "h4_islandxdock_slod",
    "h4_se_ipl_07_slod",
    "h4_islandxdock",
    "h4_islandxdock_props_2_slod",
    "h4_islandairstrip_props",
    "h4_sw_ipl_09",
    "h4_ne_ipl_06",
    "h4_se_ipl_03_lod",
    "h4_nw_ipl_03",
    "h4_islandx_mansion_lockup_01_lod",
    "h4_beach_lod",
    "h4_ne_ipl_07_lod",
    "h4_nw_ipl_01",
    "h4_mph4_island_lod",
    "h4_islandx_mansion_office_lod",
    "h4_islandairstrip_lod",
    "h4_beach_props_lod",
    "h4_nw_ipl_05_slod",
    "h4_islandx_checkpoint_lod",
    "h4_nw_ipl_05_lod",
    "h4_nw_ipl_03_slod",
    "h4_nw_ipl_03_lod",
    "h4_sw_ipl_05",
    "h4_mph4_mansion",
    "h4_sw_ipl_03",
    "h4_se_ipl_08_slod",
    "h4_mph4_island_ne_placement",
    "h4_aa_guns",
    "h4_islandairstrip_propsb_slod",
    "h4_sw_ipl_01",
    "h4_mansion_remains_cage",
    "h4_nw_ipl_01_slod",
    "h4_ne_ipl_06_lod",
    "h4_se_ipl_08",
    "h4_sw_ipl_04_slod",
    "h4_sw_ipl_04_lod",
    "h4_mph4_beach",
    "h4_sw_ipl_06_lod",
    "h4_sw_ipl_06_slod",
    "h4_se_ipl_00_lod",
    "h4_ne_ipl_07_slod",
    "h4_mph4_mansion_strm_0",
    "h4_nw_ipl_02_slod",
    "h4_mph4_airstrip",
    "h4_island_padlock_props",
    "h4_islandairstrip_props_slod",
    "h4_nw_ipl_06",
    "h4_sw_ipl_09_lod",
    "h4_islandxcanal_props_lod",
    "h4_ne_ipl_05_slod",
    "h4_se_ipl_09_slod",
    "h4_islandx_mansion_vault_lod",
    "h4_se_ipl_03_slod",
    "h4_nw_ipl_08_lod",
    "h4_islandx_barrack_props_slod",
    "h4_islandxtower_veg_slod",
    "h4_sw_ipl_04",
    "h4_islandx_mansion_props",
    "h4_islandxtower_slod",
    "h4_beach_props",
    "h4_islandx_mansion_b_slod",
    "h4_islandx_maindock_props_slod",
    "h4_sw_ipl_07_slod",
    "h4_ne_ipl_07",
    "h4_islandxdock_props_2",
    "h4_ne_ipl_09_lod",
    "h4_islandxcanal_props",
    "h4_beach_slod",
    "h4_sw_ipl_00_slod",
    "h4_sw_ipl_03_lod",
    "h4_islandx_disc_strandedshark",
    "h4_islandx_disc_strandedshark_lod",
    "h4_islandx",
    "h4_islandx_props_lod",
    "h4_mph4_island_strm_0",
    -- "h4_islandx_sea_mines",
    "h4_mph4_island",
    -- "h4_boatblockers",
    "h4_mph4_island_long_0",
    "h4_islandx_disc_strandedwhale",
    "h4_islandx_disc_strandedwhale_lod",
    "h4_islandx_props",
    "h4_int_placement_h4",
}

function toggleIpls(enabled)
    for _, Ipl in ipairs(Ipls) do
        if enabled then
            RequestIpl(Ipl)
        else
            RemoveIpl(Ipl)
        end
    end
end

Citizen.CreateThread(function()
    local interiorID = 280065
    if IsValidInterior(interiorID) then      
        ActivateInteriorEntitySet(interiorID, "pearl_necklace_set")
        SetInteriorEntitySetColor(interiorID, "pearl_necklace_set", 1)
        ActivateInteriorEntitySet(interiorID, "pink_diamond_set")
        SetInteriorEntitySetColor(interiorID, "pink_diamond_set", 1)
        RefreshInterior(interiorID)
    end
end)

CreateThread(function()
	while true do
		if nearIsland then
			SetRadarAsExteriorThisFrame()
			SetRadarAsInteriorThisFrame(`h4_fake_islandx`, vec(4700.0, -5145.0), 0, 0)
			Citizen.Wait(0)
		else
			Citizen.Wait(1000)
		end
	end
end)

CreateThread(function()
    SetZoneEnabled(GetZoneFromNameId("PrLog"), false) -- REMOVES SNOW FROM CP
    SetScenarioGroupEnabled('Heist_Island_Peds', 1)
    SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', 1, 1) -- Ambient Sounds For Cayo Perico
    SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', 0, 1) -- Disable Other Ambient Sounds

    while true do
        local coords = GetEntityCoords(PlayerPedId())

        if #(coords - islandCoords) < 2000.0 then
            if not nearIsland then
                nearIsland = true
                toggleIpls(true)
                SetIslandHopperEnabled("HeistIsland", true)  -- Switch to CP
                SetAiGlobalPathNodesType(1) -- island path nodes CP
                SetToggleMinimapHeistIsland(true) -- Cayo Perico Mini Map
                LoadGlobalWaterType(1)
                SetDeepOceanScaler(0.0)
            end
        else
            if nearIsland then
                nearIsland = false
                toggleIpls(false)
                SetIslandHopperEnabled("HeistIsland", false) -- Switch to LS
                SetAiGlobalPathNodesType(0) -- island path nodes switched to LS
                SetToggleMinimapHeistIsland(false) -- Cayo Perico Mini Map Disabled 
                LoadGlobalWaterType(0)
                SetDeepOceanScaler(1.0)
            end
        end

        Citizen.Wait(500)
    end
end)

