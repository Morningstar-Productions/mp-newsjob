local config = require 'config.server'

AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
		exports.ox_inventory:RegisterShop("reporterShop", {
            name = "Weazel News Equipment",
            inventory = config.shopItems,
        })
	end
end)

lib.callback.register('mp-newsjob:server:SpawnVehicle', function(source, model, coords, warp)
    local netId, veh = qbx.spawnVehicle({
        model = model,
        spawnSource = coords,
        warp = warp
    })

    if netId then return netId end
    if not veh or not veh == 0 then return end

    SetVehicleEngineOn(veh, false, false, true)
    SetVehicleDirtLevel(veh, 0.0)

    return netId
end)

lib.callback.register('mp-newsjob:server:getKeys', function(source, plate)
    if config.addKey(source, plate) then
        return true
    end

    return false
end)

lib.callback.register('mp-newsjob:server:getJobVehicles', function(_, jobGrade)
    print(json.encode(config.jobVehicles), print)

    return config.jobVehicles[jobGrade]
end)

lib.callback.register('mp-newsjob:server:getAirVehicles', function(_, jobGrade)
    return config.jobVehicles[jobGrade]
end)