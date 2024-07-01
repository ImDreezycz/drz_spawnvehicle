fx_version 'cerulean'
game 'gta5'
lua54 'yes'
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

author 'DRZ TEAM'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua'
}

client_script {
    'client/*.lua'
}

escrow_ignore {
    'shared/*.lua',
}

files {
    'locales/en.json'
}