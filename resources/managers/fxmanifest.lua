shared_script '@vin_asuransikeliling/shared_fg-obfuscated.lua'
-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

fx_version 'adamant'
games {'gta5'}
version '1.0.0'

ui_page 'html/ui.html'

files {
  'html/**/*.*',
}

shared_scripts{
  "shared/**/*.lua",
}

client_scripts {
  'bob74_ipl/**/*.lua',
  'lib/common.lua',
  'lib/observers/interiorIdObserver.lua',
  'lib/observers/officeSafeDoorHandler.lua',
  "client/**/*.lua",
}

server_scripts {
  "server/**/*.lua",
}

server_exports {
  'getCurrentGameType',
  'getCurrentMap',
  'changeGameType',
  'changeMap',
  'doesMapSupportGameType',
  'getMaps',
  'roundEnded',
}