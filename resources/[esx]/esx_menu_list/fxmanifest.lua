shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
fx_version 'adamant'

game 'gta5'

description 'REDESIGN V2 by Re1ease#0001'

version '1.0.2'

client_scripts {
	'@vinzz/client/wrapper.lua',
	'client/main.lua'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',

	'html/css/app.css',

	'html/js/mustache.min.js',
	'html/js/app.js',

	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic.ttf'
}

dependency 'vinzz'
