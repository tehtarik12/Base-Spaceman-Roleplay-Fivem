shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'adamant'

game 'gta5'

lua54 'yes'
description '#KCMROLEPLAY vehicle'

version '1.0.0'


shared_script '@ox_lib/init.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@vinzz/locale.lua',
	'locales/en.lua',
	'sv_esx.lua',
	'config/*.lua',
	'server/**/*.lua',
}

client_scripts {
	'@vinzz/locale.lua',
	'locales/en.lua',
	'cl_esx.lua',
	'config/*.lua',
	'client/**/*.lua',
}