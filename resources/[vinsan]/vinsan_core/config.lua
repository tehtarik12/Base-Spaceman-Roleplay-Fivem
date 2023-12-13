Config = {}

Config.Locale = "en"

Config.DefaultSpawn = {
	
	['Pelabuhan'] = {
		coord = { x = -716.8246, y = -1296.1678, z = 6.1019},
		icon = 'fas fa-building',
		label = 'Pelabuhan Los Santos',
	},
	['Bandara'] = {
		coord = { x = -1037.9736328125, y = -2738.1494140625, z = 20.1640625 },
		icon = 'fas fa-plane-arrival',
		label = 'Bandara Los Santos',
	},
}

Config.CityHall = {
	{ coords = vector3(-550.2787, -192.5441, 38.2193), name = 'Personal Requirement', type = 'personalrequirement'},
}

Config.PricePersonal = {
	['ktp'] = 100,
	['sim'] = 100,
	['license'] = 100,
}

Config.JobsColor = {
    ['police'] = 77,
    ['ambulance'] = 1,
}


Config.vehicle = 'lc100'

Config.useMythicNotify = true

Config.Lang = {
    ['already_claimed'] = 'Kamu sudah mengambil starterpack',
    ['success_claim'] = 'Kamu telah claim kendaraan starterpack. Cek garasi kamu',
    ['not_exists'] = 'Kendaraan starterpack tidak ditemukan'
}

Config.Debug = false-- If you want debug in console
Config.DefaultVolume = 0.1 -- Accepted values are 0.01 - 1
Config.Distance = 5.0 -- Dont touch this

--- Target system ---
Config.ox_target = false -- If you want to use qtarget you need also polyzone script

--- Locations ---
Config.Locations = {
    {
        onlyJob = true, -- If false then everyone can access the location
        job = 'pedagang', -- if onJob true, you have to write the name of that job here like 'vanilla'
        name = 'Uwu Cat Cafe', -- Name of zone
        coords = vec3(-583.3145, -1061.6299, 22.3442), -- Coordinates where menu will appear if you are nearby
        radius = 20, -- Playing music distance (radius)
        distance = 0.5, -- Menu appear distance
        isPlaying = false -- Dont touch this!!!!
    },
    {
        onlyJob = true,
        job = 'pedagang',
        name = 'Bahama',
        coords = vec3(-1199.0181, -1136.9524, 7.8333),
        radius = 15,
        distance = 1.5,
        isPlaying = false
    },
    {
        onlyJob = false,
        job = 'nil',
        name = 'Galaxy',
        coords = vec3(376.19, 275.45, 92.39),
        radius = 30,
        distance = 2.5,
        isPlaying = false
    },
    {
        onlyJob = false,
        job = 'nil',
        name = 'Tequila',
        coords = vec3(-562.11, 281.66, 85.6764),
        radius = 30,
        distance = 2.5,
        isPlaying = false
    }
}

Config.Language = {
    ['openMenu'] = '[E] - Open a DJ Menu',
    ['titleMenu'] = '💿 | Playlist',
    ['playSong'] = '🎶 | Play a song',
    ['playSongDesc'] = 'Enter a youtube URL',
    ['pauseMusic'] = '⏸️ | Pause Music',
    ['pauseMusicDesc'] = 'Pause a currently playing music',
    ['resumeMusic'] = '▶️ | Resume Music',
    ['resumeMusicDesc'] = 'Resume playing paused music',
    ['changeVolume'] = '🔈 | Change Volume',
    ['changeVolumeDesc'] = 'Change volume of song',
    ['stopMusic'] = '❌ | Turn off music',
    ['stopMusicDesc'] = 'Stop the music & choose a new song',
    ['songSel'] = 'Song Selection',
    ['url'] = 'Youtube URL',
    ['musicVolume'] = 'Music Volume',
    ['musicVolumeNm'] = 'Min: 0.01 - Max: 1', -- Pls dont change numbers (0.01 - 1)

    --- Playlist ---
    ['playlistMenu'] = '🎶 | DJ Playlist',
    ['playlistDesc'] = 'Play a song from playlist',
    ['playlistMenuTitle'] = '🎶 | Play a song'
}

Config.Playlist = {
    --- First Song
    ['first'] = '💿 | Uwu Playlist 1', -- Name of first song
    ['desc_first'] = 'No Copyright', -- Description of the song
    ['music_first_id'] = 'https://www.youtube.com/watch?v=Yy2U4p8EbVA', -- Url from YT

    --- Second Song ---
    ['second'] = '💿 | Casino Playlist 2', -- Name of second song
    ['desc_second'] = 'No Copyright',
    ['music_second_id'] = 'https://www.youtube.com/watch?v=dGTgBVgRfJI',

    --- Third Song ---
 --   ['third'] = '💿 | Good With It', -- Name of third song
 --   ['desc_third'] = 'Description of the song',
  --  ['music_third_id'] = 'https://www.youtube.com/watch?v=RInypZYiiDM',

    --- Fourth Song ---
  --  ['fourth'] = '💿 | Back To You',
  --  ['desc_fourth'] = 'Description of the song',
  --  ['music_fourth_id'] = 'https://www.youtube.com/watch?v=rrzHAoA-oRI',

    --- Fifth Song ---
  --  ['fifth'] = '💿 | Curse',
   -- ['desc_fifth'] = 'Description of the song',
   -- ['music_fifth_id'] = 'https://www.youtube.com/watch?v=XsmuiDRKbDk'
}

--[[
Config.playerID = true				
Config.steamID = true				
Config.steamURL = true				
Config.discordID = true
Config.xblID = true	
Config.liveID = true
Config.licenseID = true]]--


--Config.Logo = "https://media.discordapp.net/attachments/1084925098034737172/1084927976262619248/HP_SPACEMAN.png"	