-- // DONT CHANGE
local oIsAnimationOn = false
local oObjectProp = "calculator_terbium"
local oObject_net = nil

-- RegisterCommand('hesap', function(source, args, rawCommand)
--     TriggerServerEvent('hesap:varmı')
-- end)

RegisterNetEvent('hesap:var')
AddEventHandler('hesap:var', function(source)
    if (oIsAnimationOn == false) then
        Calculator()
    end
end)

RegisterNUICallback("close",function(data,cb)
    Calculator()
end)


function Calculator()
    local player = GetPlayerPed(-1)
    local playerID = PlayerId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
    local phoneRspawned = CreateObject(GetHashKey(oObjectProp), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
    local netid = ObjToNet(phoneRspawned)
    local ad = "amb@world_human_stand_mobile@female@text@enter"
    local ad2 = "amb@world_human_stand_mobile@female@text@base"
    local ad3 = "amb@world_human_stand_mobile@female@text@exit"

    if (DoesEntityExist(player) and not IsEntityDead(player)) then
        loadAnimDict(ad)
        loadAnimDict(ad2)
        loadAnimDict(ad3)
        RequestModel(GetHashKey(oObjectProp))
        if oIsAnimationOn == true then
            EnableGui(false)
            TaskPlayAnim(player, ad3, "exit", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
            Wait(1840)
            DetachEntity(NetToObj(oObject_net), 1, 1)
            DeleteEntity(NetToObj(oObject_net))
            Wait(750)
            ClearPedSecondaryTask(player)
            oObject_net = nil
            oIsAnimationOn = false
        else
            oIsAnimationOn = true
            Wait(500)
            SetNetworkIdExistsOnAllMachines(netid, true)
            NetworkSetNetworkIdDynamic(netid, true)
            SetNetworkIdCanMigrate(netid, false)
            TaskPlayAnim(player, ad, "enter", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
            Wait(1360)
            AttachEntityToEntity(phoneRspawned,GetPlayerPed(playerID),GetPedBoneIndex(GetPlayerPed(playerID), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
            oObject_net = netid
            Wait(200)
            EnableGui(true)
        end
    end
end

function EnableGui(state)
    SetNuiFocus(state, state)
    local actionvariable;
    if state == true then
        actionvariable = "open"
    else
        actionvariable = "close"
    end

    SendNUIMessage({
        action = actionvariable,
    })
end



function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end
