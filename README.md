# mp-newsjob
Reworked News Job for QBCore Framework

## Support me on Ko-Fi!
### - xViperAG
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/xviperag)

## Join the [Discord](https://discord.gg/3CXrkvQVds)

# Version 2.0.0

```
- Use of Ox Resources
- Removed all DrawText Functions
```

# Credits

* [QBCore](https://github.com/qbcore-framework/) and Kakarot (https://github.com/qbcore-framework/qb-newsjob/)
* [xFutte](https://github.com/xFutte) for futte-newspaper (https://github.com/xFutte/futte-newspaper)

## If you have any ideas or have added things to the script, don't be afraid to make a Pull Request!

## Dependencies:

* ox_target https://github.com/overextended/ox_target
* ox_inventory https://github.com/overextended/ox_inventory/releases
* ox_lib https://github.com/overextended/ox_lib/releases
* futte-newspaper https://github.com/xFutte/futte-newspaper/releases
* qb-core https://github.com/qbcore-framework/qb-core

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
