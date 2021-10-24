local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

sS = {}
local ped = nil
UAttachs = {}
UiOpen = false
Tunnel.bindInterface(GetCurrentResourceName(),sS)
sSERVER = Tunnel.getInterface(GetCurrentResourceName())

RegisterCommand("cw",function(source,args)
    if sSERVER.HasPermission() and not UiOpen then
        SendNUIMessage({ action = "show"})
        SetNuiFocus(true, true)
        UiOpen = true
    end
end)

RegisterNUICallback("CloseUi", function(data)
    SetNuiFocus(false, false)
    UiOpen = false
end)

RegisterNUICallback("ChangeTexture", function(data)
    if data.url and data.type and UiOpen then
        sSERVER.ChangeTexture(GetSelectedPedWeapon(ped),data.url,data.type,data.h,data.w)
        SendNUIMessage({ action = "close"})
        SetNuiFocus(false, false)
        UiOpen = false
    end
end)

RegisterNUICallback("EquipAttachs", function()
    if UiOpen then
        GiveAttachs()
    end
end)

function GiveAttachs()
    local NowWeapon = GetSelectedPedWeapon(ped)
    for k,v in pairs(Attachs[NowWeapon]) do
	    GiveWeaponComponentToPed(ped,NowWeapon,v)
    end
end

function sS.ChangeTexture(hash,url,type,h,w)
    local txd = CreateRuntimeTxd('duiTxd')
    local duiObj = CreateDui(url, parseInt(h),parseInt(w))
    _G.duiObj = duiObj
    local dui = GetDuiHandle(duiObj)
    local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)
    if type == "guns" then
        AddReplaceTexture(Weapons[hash], Weapons[hash], 'duiTxd', 'duiTex')    
    end

    if type == "attachs" then
        for k,v in pairs(Attachs) do 
            AddReplaceTexture(v, v, 'duiTxd', 'duiTex')    
        end
    end
end

CreateThread(function()
    while true do 
        ped = PlayerPedId() 
        Wait(1000)
    end
end)

exports("GiveAttachs",GiveAttachs)
RegisterKeyMapping("cw","Abre UI de troca de camuflagem","keyboard","f6")
