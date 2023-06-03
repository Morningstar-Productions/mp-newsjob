fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'mp-newsjob'
description 'Enhanced News Job for QBCore'
author 'xViperAG'
version '2.0.0'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/main.lua',
    'client/camera.lua',
}

server_script 'server/main.lua'

dependencies {
    'futte-newspaper',
    'ox_lib',
    'qb-target',
    'ox_inventory'
}
