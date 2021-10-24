local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

sS = {}
Tunnel.bindInterface(GetCurrentResourceName(),sS)
sCLIENT = Tunnel.getInterface(GetCurrentResourceName())

function sS.HasPermission()
    local user_id = vRP.getUserId(source)
    if user_id then
        if NecessaryPerm then
            if vRP.hasPermission(user_id,NecessaryPerm) then
                return true
            else 
                return false
            end
        end

        if NecessaryItem then
            if ItemFunction(user_id,NecessaryItem) > 1 then
                return true
            else 
                return false
            end
        end

        return true
    end
end

function sS.ChangeTexture(hash,url,type,h,w)
    if hash and url then
        sCLIENT.ChangeTexture(source,hash,url,type,h,w)
    end
end