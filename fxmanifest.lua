fx_version 'cerulean'
games {'gta5'}
version '1.0'


description 'FIB heist script by nxte'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/client.lua',
    'client/target.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'config.lua'
}

lua54 'yes'