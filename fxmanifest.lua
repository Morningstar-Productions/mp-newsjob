fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'

name 'mp-newsjob'
description 'Enhanced News Job for QBCore'
author 'xViperAG'
version '2.1.0'

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
    'ox_target',
    'ox_inventory'
}
