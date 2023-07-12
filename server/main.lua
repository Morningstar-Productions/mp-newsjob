AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
		exports.ox_inventory:RegisterShop("reporterShop", {
            name = "Weazel News Equipment",
            inventory = Config.Items
        })
	end
end)
