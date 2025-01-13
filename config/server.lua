return {
    ---@param source integer
    ---@param plate string
    addKey = function(source, plate)
        exports['Renewed-Vehiclekeys']:addKey(source, plate)
    end,

    shopItems = {
        { name = "newscamera", price = 100 },
        { name = "newsboom", price = 100 },
        { name = "newsmic", price = 100 },
        { name = 'newslight', price = 100 }
    },

    jobVehicles = {
        -- Grade 0
        [0] = { ["newsvan"] = "Weazel News Van" },
        -- Grade 1
        [1] = { ["newsvan"] = "Weazel News Van" },
        -- Grade 2
        [2] = { ["newsvan"] = "Weazel News Van" },
        -- Grade 3
        [3] = { ["newsvan"] = "Weazel News Van" },
        -- Grade 4
        [4] = { ["newsvan"] = "Weazel News Van" }
    },

    airVehicles = {
        -- Grade 0
        [0] = { ["newsmav"] = "Weazel News Maverick" },
        -- Grade 1
        [1] = { ["newsmav"] = "Weazel News Maverick" },
        -- Grade 2
        [2] = { ["newsmav"] = "Weazel News Maverick" },
        -- Grade 3
        [3] = { ["newsmav"] = "Weazel News Maverick" },
        -- Grade 4
        [4] = { ["newsmav"] = "Weazel News Maverick" }
    }
}