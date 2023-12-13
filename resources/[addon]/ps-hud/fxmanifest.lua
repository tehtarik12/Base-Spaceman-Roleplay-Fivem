shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

description 'ps-hud'
version '2.1.0'

lua54 'yes'
use_fxv2_oal 'yes'

shared_scripts {
	'@vinzz/imports.lua',
	'@ox_lib/init.lua',
	'locales/en.lua',
	'config.lua',
	'uiconfig.lua'
}

client_script  {
	'client.lua',
	'seatbelt.lua',
	'cruise.lua'
}
server_script {
	'server.lua',
}

ui_page 'html/index.html'

files {
	'html/*',
}