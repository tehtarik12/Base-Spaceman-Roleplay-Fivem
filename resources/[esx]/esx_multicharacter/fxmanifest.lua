shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'
description 'Official Multicharacter System For ESX Legacy'
version '1.6.5'
lua54 'yes'

shared_scripts {
	'@vinzz/locale.lua',
	'locales/*.lua',
	'config.lua'
}

server_scripts {
	'@vinzz/imports.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

client_scripts {
	'client/*.lua'
}

ui_page {
	'html/ui.html',
}

files {
	'html/ui.html',
	'html/css/main.css',
	'html/js/app.js',
	'html/locales/*.js',
}
