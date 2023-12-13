shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

version '2.7.1'
description 'https://github.com/thelindat/linden_outlawalert'
versioncheck 'https://raw.githubusercontent.com/thelindat/linden_outlawalert/master/fxmanifest.lua'

client_scripts {
    '@vinzz/locale.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'client/esx.lua',
    'client/main.lua',
}

shared_script 'config.lua'

server_scripts {
    '@vinzz/locale.lua',
    '@oxmysql/lib/MySQL.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'server.lua',
}

ui_page {
    'html/alerts.html',
}

files {
	'html/alerts.html',
	'html/main.js', 
	'html/style.css',
}

export "getSpeed"           -- exports['linden_outlawalert']:getSpeed
export "getStreet"          -- exports['linden_outlawalert']:getStreet
export "zoneChance"         -- exports['linden_outlawalert']:zoneChance('Custom', 2)
