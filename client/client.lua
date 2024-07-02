lib.locale()

if DRZ.FrameWork == "esx" then
    ESX = exports.es_extended:getSharedObject()
elseif DRZ.FrameWork =="qb" then
    QBCore = exports['qb-core']:GetCoreObject()
end

if DRZ.FrameWork == 'esx' then
    RegisterCommand(DRZ.Command, function()
        TriggerServerEvent('drz_spawnvehicle:checkAdminPermission')
    end, false)
end

RegisterNetEvent('drz_spawnvehicle:spawnVehicle')
AddEventHandler('drz_spawnvehicle:spawnVehicle', function()
    local spawnCode = ''
    local regNumber = 'DRZ'
    local vehicleColor = '#eb4034'
    local fullTuning = DRZ.FullTuning

    local playerPed = PlayerPedId()
    local isInVehicle = IsPedInAnyVehicle(playerPed, false)
    local currentVehicle = nil

    if isInVehicle then
        currentVehicle = GetVehiclePedIsIn(playerPed, false)
    end

    local input = lib.inputDialog('Vehicle Spawn Menu', {
        {type = 'input', label = locale("spawn_code"), name = 'spawnCode', value = '', required = true},
        {type = 'input', label = locale("registration_number"), name = 'regNumber', value = regNumber, min = 0, max = 8},
        {type = 'color', label = locale("vehicle_color"), name = 'vehicleColor', default = DRZ.DefaultColor},
        {type = 'checkbox', label = locale("full_tuning"), name = 'fullTuning'},
    })

    if input then
        spawnCode = input[1]
        regNumber = input[2]
        vehicleColor = input[3]
        fullTuning = input[4] or DRZ.FullTuning

        if regNumber == '' then
            regNumber = DRZ.Spz
        end

        local playerPos = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)

        local vehicleHash = GetHashKey(spawnCode)

        if not IsModelInCdimage(vehicleHash) then
            if DRZ.Notify == 'okok' then
                exports['okokNotify']:Alert(locale("notify_title"), locale("notify_desc1") .. spawnCode .. locale("notify_desc2"), 3000, DRZ.NotifyType)
            elseif DRZ.Notify == 'ox' then
                lib.notify({
                    title = locale("notify_title"),
                    description = locale("notify_desc1") .. spawnCode .. locale("notify_desc2"),
                    type = DRZ.NotifyType
                })
            elseif DRZ.Notify == 'custom' then
                --Your custom notify
            end
            return
        end

        RequestModel(vehicleHash)
        while not HasModelLoaded(vehicleHash) do
            Wait(500)
        end

        if isInVehicle and currentVehicle then
            SetEntityAsMissionEntity(currentVehicle, true, true)
            DeleteVehicle(currentVehicle)
        end

        local spawnedVehicle = CreateVehicle(vehicleHash, playerPos.x, playerPos.y, playerPos.z, heading, true, false)
        TaskWarpPedIntoVehicle(playerPed, spawnedVehicle, -1)

        SetVehicleNumberPlateText(spawnedVehicle, regNumber)

        local r, g, b = HexToRGB(vehicleColor)
        SetVehicleCustomPrimaryColour(spawnedVehicle, r * 255, g * 255, b * 255)
        SetVehicleCustomSecondaryColour(spawnedVehicle, r * 255, g * 255, b * 255)

        if fullTuning then
            SetVehicleModKit(spawnedVehicle, 0)
            SetVehicleMod(spawnedVehicle, 11, GetNumVehicleMods(spawnedVehicle, 11) - 1, false)
            SetVehicleMod(spawnedVehicle, 12, GetNumVehicleMods(spawnedVehicle, 12) - 1, false)
            SetVehicleMod(spawnedVehicle, 13, GetNumVehicleMods(spawnedVehicle, 13) - 1, false)
            SetVehicleMod(spawnedVehicle, 15, GetNumVehicleMods(spawnedVehicle, 15) - 1, false)
            SetVehicleMod(spawnedVehicle, 16, GetNumVehicleMods(spawnedVehicle, 16) - 1, false)
            SetVehicleMod(spawnedVehicle, 17, GetNumVehicleMods(spawnedVehicle, 17) - 1, false)
            SetVehicleMod(spawnedVehicle, 18, GetNumVehicleMods(spawnedVehicle, 18) - 1, false)
            SetVehicleMod(spawnedVehicle, 40, GetNumVehicleMods(spawnedVehicle, 40) - 1, false)
        end
    end
end)

function HexToRGB(hex)
    hex = hex:gsub("#", "")
    local r = tonumber("0x" .. hex:sub(1, 2))
    local g = tonumber("0x" .. hex:sub(3, 4))
    local b = tonumber("0x" .. hex:sub(5, 6))
    return r / 255, g / 255, b / 255
end
