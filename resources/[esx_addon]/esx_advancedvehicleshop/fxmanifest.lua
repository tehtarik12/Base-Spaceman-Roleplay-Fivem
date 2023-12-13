shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'adamant'

game 'gta5'

description 'ESX Advanced Vehicle Shop'

Author 'Human Tree92 | Velociti Entertainment'

version 'legacy'

shared_script '@vinzz/imports.lua'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@vinzz/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua',
	--'server/migrate.lua'
}

client_scripts {
	'@vinzz/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/utils.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}

export 'GeneratePlate'
