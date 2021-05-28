ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('hesap', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('hesap:var', source)
end)

RegisterServerEvent('hesap:varmı')
AddEventHandler('hesap:varmı', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('hesap').count == 1 then
        TriggerClientEvent('hesap:var', source)
    else
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde hesap makinesi yok.')
    end
end)