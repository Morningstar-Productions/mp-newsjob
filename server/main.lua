AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
		exports.ox_inventory:RegisterShop("reporterShop", {
            name = "Weazel News Equipment",
            inventory = Config.Items
        })
	end
end)

exports("newsbmic", function(source, item, inv, slot, data)
    local src = source

    item = inv.items[slot]
    src = inv.id

    if type(source) == 'string' and source ~= 'usingItem' then return end

    TriggerClientEvent("Mic:ToggleBMic", src)
end)

exports("newscam", function(source, item, inv, slot, data)
    local src = source

    item = inv.items[slot]
    src = inv.id

    if type(source) == 'string' and source ~= 'usingItem' then return end

    TriggerClientEvent("Cam:ToggleCam", src)
end)

exports("newsmic", function(source, item, inv, slot, data)
    local src = source

    item = inv.items[slot]
    src = inv.id

    if type(source) == 'string' and source ~= 'usingItem' then return end

    TriggerClientEvent("Mic:ToggleMic", src)
end)
