# qb-newsjob
Reworked News Job for QBCore Framework - Added to by xViperAG

## Support me on Ko-Fi!
### - xViperAG (OuroborosRP)
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/xviperag)

# Just Added (1.0)

* Target Config for Armory, Toggle Duty, and Writing Station.
* Used futte-newspaper to create Writing Stand.
* Added Blip for Weazel News.
* Created Items for Camera, News Mic, and Boom Mic

# Working On

* New Car Spawn System
* Remove ALL DrawText3Ds from the script
* Change to PolyZone

# Credits

* Project Sloth for the Images https://discord.com/invite/projectsloth
* QBCore and Kakarot for the original resource https://github.com/qbcore-framework/qb-newsjob/
* Futte for futte-newspaper (https://github.com/xFutte/futte-newspaper)

## If you have any ideas or have added things to the script, don't be afraid to make a Pull Request!

## Dependencies:

* qb-target https://github.com/qbcore-framework/qb-target
* qb-inventory https://github.com/qbcore-framework/qb-inventory

## Optional Dependencies

* futte-newspaper https://github.com/xFutte/futte-newspaper/

## Need a Weazel News? Here are some suggestions!

You can use the Teleports, if you so choose. You would have to set up the config.

* https://www.gta5-mods.com/maps/cnn-weazel-news-building-reworked-hq (FREE)
* https://unclejust.tebex.io/package/4805269 (PAID) (This is what is set up)
* https://unclejust.tebex.io/package/4805324 (PAID)
* https://unclejust.tebex.io/package/4805160 (PAID)
* https://3dstore.nopixel.net/package/5073829 (PAID) (You can use either LSBN, Weazel News, or Both)

## Installation

* Take the images in the /images folder and paste them into your inventory of choice.

* Take the following lines and put them into your qb-core/shared/items.lua
```lua
    -- QB-NewsJob Items
	["newsmic"] 					 = {["name"] = "newsmic", 			 			["label"] = "News Microphone", 			["weight"] = 500, 		["type"] = "item", 		["image"] = "newsmic.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Microphone for News and Harrassment.. right?"},
	["newsbmic"] 					 = {["name"] = "newsbmic", 			 			["label"] = "News Boom Microphone", 	["weight"] = 1000, 		["type"] = "item", 		["image"] = "newsbmic.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Boom Microphone for News and Harrassment.. right?"},
	["newscam"] 					 = {["name"] = "newscam", 			 			["label"] = "News Camera", 				["weight"] = 750, 		["type"] = "item", 		["image"] = "newscam.png", 				["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Camera for News and Harrassment.. right?"},
```

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>
