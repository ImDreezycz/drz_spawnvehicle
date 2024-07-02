lib.locale()

if DRZ.FrameWork == "esx" then
    ESX = exports.es_extended:getSharedObject()
elseif DRZ.FrameWork =="qb" then
    QBCore = exports['qb-core']:GetCoreObject()
end

function QBCore.Functions.HasPermission(source, permission)
    if IsPlayerAceAllowed(source, permission) then return true end
    return false
end

if DRZ.FrameWork == 'qb' then
    QBCore.Commands.Add('spawnvehicle', 'spawnvehicle test', {}, false, function(source)
        if QBCore.Functions.HasPermission(source, 'admin') then
            TriggerClientEvent('drz_spawnvehicle:spawnVehicle', source)
        elseif not QBCore.Functions.HasPermission(source, 'admin') then
            if DRZ.Notify == 'okok' then
                TriggerClientEvent('okokNotify:Alert', source, locale("notify_title"), locale("notify_unauthorized"), 3000, 'error')
            elseif DRZ.Notify == 'ox' then
                TriggerClientEvent('ox_lib:notify', source, {
                    title = locale("notify_title"),
                    description = locale("notify_unauthorized"),
                    type = 'error'
                })
            elseif DRZ.Notify == 'custom' then
                -- Your custom notify
            end
        end
    end, 'admin')
end

RegisterServerEvent('drz_spawnvehicle:checkAdminPermission')
AddEventHandler('drz_spawnvehicle:checkAdminPermission', function()
    if DRZ.FrameWork == 'esx' then
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
    end
end)
