lib.locale()
ESX = exports.es_extended:getSharedObject()

RegisterServerEvent('drz_spawnvehicle:checkAdminPermission')
AddEventHandler('drz_spawnvehicle:checkAdminPermission', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == DRZ.Group then
        TriggerClientEvent('drz_spawnvehicle:spawnVehicle', source)
    else
        if DRZ.Notify == 'okok' then
            TriggerClientEvent('okokNotify:Alert', source, locale("notify_title"), locale("notify_unauthorized"), 3000, 'error')
        elseif DRZ.Notify == 'ox' then
            TriggerClientEvent('ox:notify', source, {
                title = locale("notify_title"),
                description = locale("notify_unauthorized"),
                type = 'error'
            })
        elseif DRZ.Notify == 'custom' then
            -- Your custom notify
        end
    end
end)
