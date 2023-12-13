shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
shared_scripts {
	'@vinzz/imports.lua',
	'config.lua',
}

client_scripts {
	'client.lua',
	'json.lua',
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
	'json.lua',
}

ui_page('web/index.html')

files {
    'config.json',
    'web/index.html',
    'web/script.js',
    'web/style.css',
}