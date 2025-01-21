local inHelicopter, inGarage, inPrompt = false, false, false

local vehicleSpawns = {}
local heliSpawns = {}

local config = require 'config.shared'

----------
-- Blip --
----------

local blips = require 'config.shared'.blips

if blips.useBlips then
    local blipInfo = blips.blipInfo

    CreateThread(function()
        local blip = AddBlipForCoord(blipInfo.coords.x, blipInfo.coords.y, blipInfo.coords.z)
        SetBlipSprite(blip, blipInfo.sprite)
        SetBlipDisplay(blip, blipInfo.display)
        SetBlipScale(blip, blipInfo.scale)
        SetBlipColour(blip, blipInfo.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipInfo.label)
        EndTextCommandSetBlipName(blip)
    end)
end

--------------
-- Handlers --
--------------

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CreateTargets()
    CreateWriterZone()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    if JobInfo.type == 'reporter' and QBX.PlayerData.job.type ~= 'reporter' then
        if JobInfo.onduty then
            TriggerServerEvent("QBCore:ToggleDuty")
        end
    end

    QBX.PlayerData.job = JobInfo
end)

---------------
-- Functions --
---------------

local function Notify(title, description, type, duration, icon)
    lib.notify({
        title = title,
        description = description,
        type = type,
        duration = duration,
        icon = icon
    })
end

local function TakeOutVehicle(vehicleInfo)
    if not inGarage then return end
    if QBX.PlayerData.job.type == "reporter" and QBX.PlayerData.job.onduty then

        for i = 1, #config.jobLocations.vehicle do
            local coords = config.jobLocations.vehicle[i]
            if not coords then
                local plyCoords = GetEntityCoords(cache.ped)
                coords = vec4(plyCoords.x, plyCoords.y, plyCoords.z, GetEntityHeading(cache.ped))
            end

            local netId = lib.callback.await('mp-newsjob:server:SpawnVehicle', false, vehicleInfo, coords, true)
            if not netId then return end
            local veh = NetToVeh(netId)

            local plate = qbx.getVehiclePlate(veh)

            if not plate then return end

            SetVehicleNumberPlateText(veh, plate)

            Entity(veh).state.fuel = 100
            Entity(veh).state:set('vehicleLock', { lock = 0 }, true)
            SetVehicleLivery(veh, 2)

            local giveKey = lib.callback.await('mp-newsjob:server:getKeys', false, plate)
            if not giveKey then return end
        end
    end
end

local function MenuGarage()
    local vehicleMenu = {}

    local getJobVehicles = lib.callback.await('mp-newsjob:server:getJobVehicles', false, QBX.PlayerData.job.grade.level)

    for veh, label in pairs(getJobVehicles) do
        print(json.encode(getJobVehicles))

        vehicleMenu[#vehicleMenu + 1] = {
            title = label,
            image = "https://i.postimg.cc/zD2mcDXN/Weazel-news-rumpo-white-front-gtav.webp",
            onSelect = function()
                TakeOutVehicle(veh)
            end,
        }
    end

    lib.registerContext({
        id = "weazel_news_vehicle_menu",
        title = "Weazel News Vehicles",
        options = vehicleMenu
    })
    lib.showContext('weazel_news_vehicle_menu')
end

local function TakeOutHelicopters(vehicleInfo)
    if not inHelicopter then return end
    if QBX.PlayerData.job.type == "reporter" and QBX.PlayerData.job.onduty then
        for i = 1, #config.jobLocations.heli do
            local coords = config.jobLocations.heli[i]
            if not coords then
                local plyCoords = GetEntityCoords(cache.ped)
                coords = vec4(plyCoords.x, plyCoords.y, plyCoords.z, GetEntityHeading(cache.ped))
            end

            local netId = lib.callback.await('mp-newsjob:server:SpawnVehicle', false, vehicleInfo, coords, false)
            if not netId then return end
            local veh = NetToVeh(netId)

            Entity(veh).state.fuel = 100
            SetVehicleEngineOn(veh, false, false, true)
        end
    end
end

local function MenuHeliGarage()
    local vehicleMenu = {}

    local getAirVehicles = lib.callback.await('mp-newsjob:server:getAirVehicles', false, QBX.PlayerData.job.grade.level)

    for veh, label in pairs(getAirVehicles) do
        vehicleMenu[#vehicleMenu + 1] = {
            title = label,
            image = 'https://i.postimg.cc/QM3vTHSQ/Frogger-GTAV-front.webp',
            onSelect = function()
                TakeOutHelicopters(veh)
            end,
        }
    end

    lib.registerContext({
        id = "news_heli_menu",
        title = "Weazel News Helicopter",
        onExit = function()
            lib.hideContext()
        end,
        options = vehicleMenu
    })
    lib.showContext('news_heli_menu')
end

local function uiPrompt(promptType, id)
    if QBX.PlayerData.job.type ~= 'reporter' then return end

    CreateThread(function()
        while inPrompt do
            Wait(3)
            if IsControlPressed(0, 38) then
                if promptType == 'garage' then
                    if not inGarage then return end
                    if cache.vehicle then
                        DeleteVehicle(cache.vehicle)
                        lib.hideTextUI()
                        break
                    else
                        MenuGarage()
                        lib.hideTextUI()
                        break
                    end
                elseif promptType == 'heli' then
                    if not inHelicopter then return end
                    if cache.vehicle then
                        DeleteVehicle(cache.vehicle)
                        lib.hideTextUI()
                        break
                    else
                        MenuHeliGarage()
                        lib.hideTextUI()
                        break
                    end
                end
            end
        end
    end)
end

function CreateTargets()
    local jobLocs = config.jobLocations

    for i = 1, #jobLocs.shop do
        exports.ox_target:addBoxZone({
            coords = vec3(jobLocs.shop[i].x, jobLocs.shop[i].y, jobLocs.shop[i].z),
            size = vec3(5.6, 1, 1.25),
            rotation = 0,
            debug = config.debug,
            drawSprite = true,
            options = {
                {
                    icon = "fas fa-basket-shopping",
                    label = "Open Armory",
                    onSelect = function()
                        if not QBX.PlayerData.job.onduty then
                            return Notify('Weazel News', 'You are not clocked in!', 'error', 5000, 'fas fa-newspaper')
                        end

                        exports.ox_inventory:openInventory("shop", {type = 'reporterShop'})
                    end,
                    groups = config.groups,
                    distance = 1.5
                }
            }
        })
    end

    for i = 1, #jobLocs.duty do
        exports.ox_target:addSphereZone({
            coords = vec3(jobLocs.duty[i].x, jobLocs.duty[i].y, jobLocs.duty[i].z),
            size = vec3(5.6, 1, 1.25),
            rotation = 0,
            debug = config.debug,
            drawSprite = true,
            options = {
                {
                    icon = "fas fa-basket-shopping",
                    label = "Toggle Duty",
                    onSelect = function()
                        TriggerServerEvent('QBCore:ToggleDuty')
                    end,
                    groups = config.groups,
                    distance = 1.5
                }
            }
        })
    end
end

function CreateWriterZone()
    if GetResourceState('futte-newspaper'):match('start') then return end
    local jobLocs = config.jobLocations

    for i = 1, #jobLocs.writers do
        exports.ox_target:addSphereZone({
            coords = vector3(jobLocs.writers[i].x, jobLocs.writers[i].y, jobLocs.writers[i].z),
            radius = 0.5,
            debug = config.debug,
            drawSprite = true,
            options = {
                event = "newspaper:client:openNewspaper",
                icon = "fas fa-newspaper",
                label = "Write Report",
                groups = config.groups,
                distance = 1.5
            }
        })
    end
end

---------------
-- Ox Zoning --
---------------

CreateThread(function()
    local jobLocs = config.jobLocations
    -- News Garage
    for _, v in pairs(jobLocs.vehicle) do
        local vehZones = lib.zones.box({
            coords = v,
            size = vec3(4, 3, 2),
            rotation = 0.0,
            debug = config.debug,
            onEnter = function()
                if QBX.PlayerData.job.type ~= 'reporter' then return end

                inGarage, inPrompt = true, true
                if cache.vehicle then
                    lib.showTextUI('[E] Store Vehicle', { position = 'left-center' })
                else
                    lib.showTextUI('[E] Vehicle Garage', { position = 'left-center' })
                end
                uiPrompt('garage')
            end,
            onExit = function()
                inGarage = false
                inPrompt = false
                lib.hideTextUI()
            end
        })

        vehicleSpawns[#vehicleSpawns + 1] = vehZones
    end

    -- News Helicopter
    for _, v in pairs(config.jobLocations.heli) do
        local heliZones = lib.zones.box({
            coords = v,
            size = vec3(5, 5, 4),
            rotation = 0.0,
            debug = config.debug,
            onEnter = function()
                if QBX.PlayerData.job.type ~= 'reporter' then return end

                inHelicopter, inPrompt = true, true
                if cache.vehicle then
                    lib.showTextUI('[E] Store Vehicle', { position = 'left-center', })
                else
                    lib.showTextUI('[E] Helicopter Garage', { position = 'left-center' })
                end
                uiPrompt('heli')
            end,
            onExit = function()
                inHelicopter = false
                inPrompt = false
                lib.hideTextUI()
            end
        })

        heliSpawns[#heliSpawns + 1] = heliZones
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        CreateTargets()
        CreateWriterZone()
    end
end)