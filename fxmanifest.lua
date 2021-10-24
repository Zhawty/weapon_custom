fx_version "bodacious"
game "gta5"

ui_page "web/index.html"

server_scripts {
	"@vrp/lib/utils.lua",
	'server/*'
}

client_scripts {
	"@vrp/lib/utils.lua",
	'client/*'
}

shared_scripts {
	'shared/*'
}

files {
	'web/*',
}

server_export "GiveWeapon"
export "GiveAttachs"