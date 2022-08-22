QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}
onDuty = false

----------------
-- DrawText3D --
----------------

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

----------
-- Blip --
----------

CreateThread(function()
	for _, info in pairs(Config.BlipLocation) do
		if Config.UseBlips then
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 1.0)	
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end	
end)

--------------
-- Handlers --
--------------

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "reporter" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
    if PlayerJob.name == "reporter" then
    end
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent("newsjob:Duty", function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
end)

function TakeOutVehicle(vehicleInfo)
    if PlayerJob.name == "reporter" and  onDuty then
        local coords = Config.Locations["vehicle"].coords
        QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
            local veh = NetToVeh(netId)
            SetVehicleNumberPlateText(veh, "WZNW"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            SetVehicleLivery(veh, 2)
            CurrentPlate = QBCore.Functions.GetPlate(veh)
        end, vehicleInfo, coords, true)
    end
end

function MenuGarage()
    local vehicleMenu = {
        {
            header = "Weazel News Vehicles",
            isMenuHeader = true
        }
    }

    local Vehicles = Config.Vehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(Vehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "qb-newsjob:client:TakeOutVehicle",
                args = {
                    vehicle = veh
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Close Menu",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

function TakeOutHelicopters(vehicleInfo)
    if PlayerJob.name == "reporter" and  onDuty then
    	local coords = Config.Locations["heli"].coords
    	QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
            local veh = NetToVeh(netId)
            SetVehicleNumberPlateText(veh, "WZNW"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            SetVehicleLivery(veh, 2)
            CurrentPlate = QBCore.Functions.GetPlate(veh)
    	end, vehicleInfo, coords, true)
    end
end

function MenuHeliGarage()
    local vehicleMenu = {
        {
            header = "Weazel News Helicopters",
            isMenuHeader = true
        }
    }

    local Helicopters = Config.Helicopters[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(Helicopters) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "qb-newsjob:client:TakeOutHelicopters",
                args = {
                    vehicle = veh
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Close Menu",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

CreateThread(function()
    while true do
        Wait(3)
        if LocalPlayer.state.isLoggedIn then
            local inRange = false
            local pos = GetEntityCoords(PlayerPedId())
            if PlayerJob.name == "reporter" then
                if #(pos - vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)) < 10.0 then
                    inRange = true
                    DrawMarker(2, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)) < 1.5 then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "~g~E~w~ - Store the Vehicle")
                        else
                            DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "~g~E~w~ - Vehicles")
                        end
                        if IsControlJustReleased(0, 38) then
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                            else
                                MenuGarage()
                                currentGarage = k
                            end
                        end
                    end
                elseif  #(pos - vector3(Config.Locations["heli"].coords.x, Config.Locations["heli"].coords.y, Config.Locations["heli"].coords.z)) < 5.0 then
                    inRange = true
                    DrawMarker(2, Config.Locations["heli"].coords.x, Config.Locations["heli"].coords.y, Config.Locations["heli"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(Config.Locations["heli"].coords.x, Config.Locations["heli"].coords.y, Config.Locations["heli"].coords.z)) < 1.5 then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            DrawText3D(Config.Locations["heli"].coords.x, Config.Locations["heli"].coords.y, Config.Locations["heli"].coords.z, "~g~E~w~ - Store the Helicopters")
                        else
                            DrawText3D(Config.Locations["heli"].coords.x, Config.Locations["heli"].coords.y, Config.Locations["heli"].coords.z, "~g~E~w~ - Helicopters")
                        end
                        if IsControlJustReleased(0, 38) then
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                            else
                                MenuHeliGarage()
                                currentGarage = k
                            end
                        end
                    end
                end
                if not inRange then
                    Wait(2500)
                end
            else
                Wait(2500)
            end
        else
            Wait(2500)
        end
    end
end)

RegisterNetEvent("newsjob:shop", function()
    if not onDuty then TriggerEvent('QBCore:Notify', "Not clocked in!", 'error') else
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "reporter", {
            label = "Weazel News Equipment",
            items = Config.Items,
            slots = #Config.Items,
        })
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Locations["duty"]) do
        exports['qb-target']:AddBoxZone("Duty_"..k, vector3(v.x, v.y, v.z), 1, 1, {
            name = "Duty_"..k,
            heading = 32,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {  
                    type = "client",
                    event = "newsjob:Duty",
                    icon = "far fa-clipboard",
                    label = "Clock On/Off",
                    job = "reporter",
                },
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Locations["shop"]) do
        exports['qb-target']:AddBoxZone("NewsArmory_"..k, vector3(v.x, v.y, v.z), 1, 1, {
            name = "NewsArmory_"..k,
            heading = 32,
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        }, {
            options = {
                {  
                    type = "client",
                    event = "newsjob:shop",
                    icon = "fas fa-basket-shopping",
                    label = "Open Armory",
                    job = "reporter",
                },
            },
            distance = 1.5
        })
    end
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("NewsReport", vector3(-591.67, -937.14, 23.88), 1.2, 2.8, {
        name = "NewsReport",
        heading = 0,
        debugPoly = false,
        minZ = 23.88 - 1,
        maxZ = 23.88 + 1,
    }, {
        options = {
            {  
                type = "client",
                event = "newspaper:client:openNewspaper",
                icon = "fas fa-newspaper",
                label = "Write Report",
                job = "reporter",
            },
        },
        distance = 1.5
    })
end)

RegisterNetEvent('qb-newsjob:client:TakeOutVehicle', function(data)
    local vehicle = data.vehicle
    TakeOutVehicle(vehicle)
end)

RegisterNetEvent('qb-newsjob:client:TakeOutHelicopters', function(data)
    local vehicle = data.vehicle
    TakeOutHelicopters(vehicle)
end)
