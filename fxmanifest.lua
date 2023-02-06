name "Radar"
author "Gaïus Mancini"
description "Radar Script By Gaïus Mancini"
fx_version "cerulean"
game "gta5"
dependencies {
	'qb-menu',
    'qb-target',
}
client_script {
    'client/*.lua',
    'config.lua'
}
server_script 'server/*.lua'
lua54 'yes'