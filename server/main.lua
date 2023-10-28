AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
		exports.ox_inventory:RegisterShop("reporterShop", {
            name = "Weazel News Equipment",
            inventory = Config.Items
        })
	end
end)

lib.callback.register('mp-newsjob:SpawnNewsVehicle', function(source, model, coords, warp)
    local netId = qbCore.Functions.SpawnVehicle(source, model, coords, warp)
    local veh = NetworkGetEntityFromNetworkId(netId)
    SetVehicleNumberPlateText(veh, "WZNW"..tostring(math.random(1000, 9999)))
    SetEntityHeading(veh, coords.w)
    SetVehicleFuelLevel(veh, 100.0)
    TriggerEvent("vehiclekeys:client:SetOwner", qbCore.Functions.GetPlate(veh))
    SetVehicleEngineOn(veh, true, true, false)
    SetVehicleLivery(veh, 2)
end)

lib.callback.register('mp-newsjob:SpawnNewsHeli', function(source, model, coords, warp)
    local netId = qbCore.Functions.SpawnVehicle(source, model, coords, warp)
    local veh = NetworkGetEntityFromNetworkId(netId)
    SetVehicleNumberPlateText(veh, "WZNW"..tostring(math.random(1000, 9999)))
    SetEntityHeading(veh, coords.w)
    SetVehicleFuelLevel(veh, 100.0)
    TriggerEvent("vehiclekeys:client:SetOwner", qbCore.Functions.GetPlate(veh))
    SetVehicleEngineOn(veh, true, true, false)
end)