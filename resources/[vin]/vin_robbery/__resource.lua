shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "html/index.html"

files {
	"html/index.html",
	"html/script.js",
	"html/style.css",
	"html/ui.js",
	"html/gothicb.ttf",
	"html/signpainter.ttf",
	"html/bootstrap.min.js",
	"html/bootstrap.min.css",
	"html/responsive.css",
	"html/musica/1.mp3"
}

client_script {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'client.lua',
	'config.lua'
}

server_script {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
  	'server.lua',
  	'config.lua'
}
