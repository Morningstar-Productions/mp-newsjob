local holdingCam = false
local holdingMic = false
local holdingBmic = false
local camModel = "prop_v_cam_01"
local camanimDict = "missfinale_c2mcs_1"
local camanimName = "fin_c2_mcs_1_camman"
local micModel = "p_ing_microphonel_01"
local micanimDict = "anim@heists@humane_labs@finale@keycards"
local micanimName = "ped_a_enter_loop"
local bmicModel = "prop_v_bmike_01"
local bmicanimDict = "missfra1"
local bmicanimName = "mcs2_crew_idle_m_boom"
local bmic_net = 0
local UI = { x =  0.000, y = -0.001 }
local fov_max = 70.0
local fov_min = 5.0
local zoomspeed = 10.0
local speed_lr = 8.0
local speed_ud = 8.0
local camera = false
local fov = (fov_max+fov_min)*0.5
local new_z
local movcamera
local newscamera

--FUNCTIONS--
local function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

local function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		local new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

local function HandleZoom(cam)
	local lPed = cache.ped
	if not ( IsPedSittingInAnyVehicle( lPed ) ) then

		if IsControlJustPressed(0,241) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	end
end

local function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

local function Breaking(text)
	SetTextColour(255, 255, 255, 255)
	SetTextFont(8)
	SetTextScale(1.2, 1.2)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.2, 0.85)
end

---------------------------------------------------------------------------
-- Toggling Cam --
---------------------------------------------------------------------------

local camspawned = 0
exports('newscamera', function(data, slot)
    if not holdingCam then
		holdingCam = true

		local dict = lib.requestAnimDict(camanimDict)
        TaskPlayAnim(cache.ped, dict, camanimName, 1.0, -1, -1, 50, 0, false, false, false)
		RemoveAnimDict(dict)

		lib.requestModel(GetHashKey(camModel))
		local plyCoords = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.0, -5.0)
        camspawned = CreateObject(GetHashKey(camModel), plyCoords.x, plyCoords.y, plyCoords.z, true, true, true)
        AttachEntityToEntity(camspawned, cache.ped, GetPedBoneIndex(cache.ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 0, true)
		SetModelAsNoLongerNeeded(GetHashKey(camModel))
		lib.showTextUI("Weazel Overlay: **[E]**  \nFilm Overlay: **[Q]**", { position = 'bottom-center' })
    else
		lib.hideTextUI()
		movcamera = false
		newscamera = false
        holdingCam = false
        ClearPedSecondaryTask(cache.ped)
        DeleteObject(camspawned)
    end
end)

CreateThread(function()
	while true do
		if holdingCam then
			DisablePlayerFiring(PlayerId(), true)
			DisableControlAction(0,25,true) -- disable aim
			--DisableControlAction(0, 44,  true) -- INPUT_COVER
			DisableControlAction(0,37,true) -- INPUT_SELECT_WEAPON
			SetCurrentPedWeapon(cache.ped, GetHashKey("WEAPON_UNARMED"), true)
			Wait(7)
		else
			Wait(1000)
		end
	end
end)

---------------------------------------------------------------------------
-- Movie Cam --
---------------------------------------------------------------------------

CreateThread(function()
	while true do
		if holdingCam then
			if IsControlJustReleased(1, 44) then
				if not newscamera then
					movcamera = true
					SetTimecycleModifier("default")
					SetTimecycleModifierStrength(0.3)

					local scaleform = lib.requestScaleformMovie("security_camera")
					local lPed = cache.ped
					local vehicle = GetVehiclePedIsIn(lPed)
					local cam1 = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

					if not scaleform then return end

					AttachCamToEntity(cam1, lPed, 0.0,0.0,1.0, true)
					SetCamRot(cam1, 2.0,1.0,GetEntityHeading(lPed))
					SetCamFov(cam1, fov)
					RenderScriptCams(true, false, 0, 1, 0)
					PushScaleformMovieFunction(scaleform, "security_camera")
					PopScaleformMovieFunctionVoid()

					while movcamera and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and true do
						if IsControlJustPressed(0, 177) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							movcamera = false
						end

						SetEntityRotation(lPed, 0, 0, new_z,2, true)
						local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
						CheckInputRotation(cam1, zoomvalue)
						HandleZoom(cam1)
						HideHUDThisFrame()
						drawRct(UI.x + 0.0, UI.y + 0.0, 1.0, 0.15, 0, 0, 0, 255) -- Top Bar
						DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
						drawRct(UI.x + 0.0, 	UI.y + 0.85, 1.0,0.16,0,0,0,255) -- Bottom Bar

						local camHeading = GetGameplayCamRelativeHeading()
						local camPitch = GetGameplayCamRelativePitch()

						if camPitch < -70.0 then
							camPitch = -70.0
						elseif camPitch > 42.0 then
							camPitch = 42.0
						end

						camPitch = (camPitch + 70.0) / 112.0

						if camHeading < -180.0 then
							camHeading = -180.0
						elseif camHeading > 180.0 then
							camHeading = 180.0
						end

						camHeading = (camHeading + 180.0) / 360.0
						SetTaskMoveNetworkSignalFloat(cache.ped, "Pitch", camPitch)
						SetTaskMoveNetworkSignalFloat(cache.ped, "Heading", camHeading * -1.0 + 1.0)
						Wait(1)
					end

					movcamera = false
					ClearTimecycleModifier()
					fov = (fov_max+fov_min)*0.5
					RenderScriptCams(false, false, 0, true, false)
					SetScaleformMovieAsNoLongerNeeded(scaleform)
					DestroyCam(cam1, false)
					SetNightvision(false)
					SetSeethrough(false)
				end
			end
			Wait(7)
		else
			Wait(1000)
		end
	end
end)

---------------------------------------------------------------------------
-- News Cam --
---------------------------------------------------------------------------

CreateThread(function()
	while true do
		if holdingCam then

			if IsControlJustReleased(1, 38) then
				if not movcamera then
					newscamera = true
					SetTimecycleModifier("default")
					SetTimecycleModifierStrength(0.3)

					local scaleform = lib.requestScaleformMovie("security_camera")
					local scaleform2 = lib.requestScaleformMovie("breaking_news")
					local lPed = cache.ped
					local vehicle = GetVehiclePedIsIn(lPed)
					local cam2 = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

					if not scaleform then return end
					if not scaleform2 then return end

					AttachCamToEntity(cam2, lPed, 0.0,0.0,1.0, true)
					SetCamRot(cam2, 2.0, 1.0, GetEntityHeading(lPed))
					SetCamFov(cam2, fov)
					RenderScriptCams(true, false, 0, true, false)
					PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
					PushScaleformMovieFunction(scaleform2, "breaking_news")
					PopScaleformMovieFunctionVoid()

					while newscamera and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and true do
						if IsControlJustPressed(1, 177) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
							newscamera = false
						end

						SetEntityRotation(lPed, 0, 0, new_z,2, true)
						local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
						CheckInputRotation(cam2, zoomvalue)
						HandleZoom(cam2)
						HideHUDThisFrame()
						DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
						DrawScaleformMovie(scaleform2, 0.5, 0.63, 1.0, 1.0, 255, 255, 255, 255)
						Breaking("BREAKING NEWS")

						local camHeading = GetGameplayCamRelativeHeading()
						local camPitch = GetGameplayCamRelativePitch()

						if camPitch < -70.0 then
							camPitch = -70.0
						elseif camPitch > 42.0 then
							camPitch = 42.0
						end

						camPitch = (camPitch + 70.0) / 112.0

						if camHeading < -180.0 then
							camHeading = -180.0
						elseif camHeading > 180.0 then
							camHeading = 180.0
						end

						camHeading = (camHeading + 180.0) / 360.0
						SetTaskMoveNetworkSignalFloat(cache.ped, "Pitch", camPitch)
						SetTaskMoveNetworkSignalFloat(cache.ped, "Heading", camHeading * -1.0 + 1.0)
						Wait(1)
					end

					newscamera = false
					ClearTimecycleModifier()
					fov = (fov_max+fov_min)*0.5
					RenderScriptCams(false, false, 0, true, false)
					SetScaleformMovieAsNoLongerNeeded(scaleform)
					DestroyCam(cam2, false)
					SetNightvision(false)
					SetSeethrough(false)
				end
			end
			Wait(7)
		else
			Wait(1000)
		end
	end
end)

---------------------------------------------------------------------------
--B Mic --
---------------------------------------------------------------------------

local bmicspawned = 0
exports("newsboom", function(data, slot)
    if not holdingBmic then
		holdingBmic = true

		local dict = lib.requestAnimDict(bmicanimDict)
		TaskPlayAnim(cache.ped, bmicanimDict, bmicanimName, 1.0, -1, -1, 50, 0, false, false, false)
		RemoveAnimDict(dict)

		lib.requestModel(GetHashKey(bmicModel))
        local plyCoords = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.0, -5.0)
        bmicspawned = CreateObject(GetHashKey(bmicModel), plyCoords.x, plyCoords.y, plyCoords.z, true, true, false)
		AttachEntityToEntity(bmicspawned, cache.ped, GetPedBoneIndex(cache.ped, 28422), -0.08, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 0, true)
		SetModelAsNoLongerNeeded(GetHashKey(bmicModel))
	else
        ClearPedSecondaryTask(cache.ped)
		DeleteObject(bmicspawned)
        holdingBmic = false
    end
end)

CreateThread(function()
	while true do
		if holdingBmic then
			if not IsEntityPlayingAnim(cache.ped, bmicanimDict, bmicanimName, 3) then
				TaskPlayAnim(cache.ped, bmicanimDict, bmicanimName, 1.0, -1, -1, 50, 0, false, false, false)
			end
			DisablePlayerFiring(PlayerId(), true)
			DisableControlAction(0,25,true) -- disable aim
			--DisableControlAction(0, 44,  true) -- INPUT_COVER
			DisableControlAction(0,37,true) -- INPUT_SELECT_WEAPON
			SetCurrentPedWeapon(cache.ped, GetHashKey("WEAPON_UNARMED"), true)
			if cache.vehicle or QBX.PlayerData.metadata.ishandcuffed or holdingMic then
				ClearPedSecondaryTask(cache.ped)
				DetachEntity(NetToObj(bmic_net), true, true)
				bmic_net = 0
				holdingBmic = false
			end
			Wait(7)
		else
			Wait(1000)
		end
	end
end)

---------------------------------------------------------------------------
-- Events --
---------------------------------------------------------------------------

-- Activate camera
RegisterNetEvent('camera:Activate', function()
	camera = not camera
end)

---------------------------------------------------------------------------
-- Toggling Mic --
---------------------------------------------------------------------------
local micspawned = 0
exports("newsmic", function(data, slot)
    if not holdingMic then
		holdingMic = true

		local dict = lib.requestAnimDict(micanimDict)
		TaskPlayAnim(cache.ped, micanimDict, micanimName, 1.0, -1, -1, 50, 0, false, false, false)
		RemoveAnimDict(dict)

		lib.requestModel(GetHashKey(micModel))
		local plyCoords = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.0, -5.0)
		micspawned = CreateObject(GetHashKey(micModel), plyCoords.x, plyCoords.y, plyCoords.z, true, true, true)
        AttachEntityToEntity(micspawned, cache.ped, GetPedBoneIndex(cache.ped, 4154), -0.00, -0.0200, 0.1100, 0.00, 0.0, 60.0, true, true, false, true, 0, true)
		SetModelAsNoLongerNeeded(GetHashKey(micModel))
	else
        ClearPedSecondaryTask(cache.ped)
        DeleteObject(micspawned)
        holdingMic = false
    end
end)
