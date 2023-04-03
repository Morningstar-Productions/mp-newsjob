local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
		exports.ox_inventory:RegisterShop("reporterShop", {
            label = "Weazel News Equipment",
            inventory = Config.Items,
        })
	end
end)

QBCore.Functions.CreateUseableItem("newsbmic", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    TriggerClientEvent("Mic:ToggleBMic", source)
end)

QBCore.Functions.CreateUseableItem("newscam", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    TriggerClientEvent("Cam:ToggleCam", source)
end)

QBCore.Functions.CreateUseableItem("newsmic", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    TriggerClientEvent("Mic:ToggleMic", source)
end)
