---------------------------------------------------------------------------------------------
======================================== ESX Framework ========================================
-----------------------------------------------------------------------------------------------
--	
##			This is referance material to use with codeing ESX related modifications.
--	
##			Compliled by DK_DonnieKongy from https://esx-org.github.io/es_extended/ 
--	
---=========================================================================================---
=========================================== Common ============================================
---=========================================================================================---
--	
##			    These functions can be used in both Client and Server side code.
--	
-----------------------------------------------------------------------------------------------
========================================== Functions ==========================================
-----------------------------------------------------------------------------------------------

ESX.GetRandomString

 
ESX.GetRandomString(length)
This function gets a random string, with the defined length.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.GetWeaponComponent


ESX.GetWeaponComponent(weaponName, weaponComponent)
This function returns the weapon component object for a weapon. 
Includes the component label, name and hash key. See the weapon config file for the available components.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.GetWeaponLabel

ESX.GetWeaponLabel(weaponName)
This function gets the weapon label for a given weapon.

local label = ESX.GetWeaponLabel('WEAPON_ASSAULTRIFLE')

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.GetWeaponList

ESX.GetWeaponList()
This function gets the complete weapon list and label.

local list = ESX.GetWeaponList()

for i=1, #list, 1 do
    print(list[i].name .. ' => ' .. list[i].label)
end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Math.GroupDigits

ESX.Math.GroupDigits(value)
This function groups numbers, making them easier to understand by humans. 
Used in most nofications when money is showed, for example when buying a new car at the vehicle shop.

local value = 5555
local valueGrouped = ESX.Math.GroupDigits(5555)

print(value, valueGrouped) -- returns 5555, 5,555

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Math.Round

ESX.Math.Round(value, numDecimalPlaces)
This function rounds off a number, and optionally you can parse how many decimals you want (defaults to 0)

local value - 5.444

print('value: ' .. value) -- returns 5.444
print('value rounded: ' .. ESX.Math.Round(value)) -- returns 5
print('value rounded: ' .. ESX.Math.Round(value, 1)) -- returns 5.4

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Math.Trim

ESX.Math.Trim(value)
This function trims an text, removing all trailing whitespaces. Often used when sanitizing the GetVehicleNumberPlateText() native.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.SetTimeout

ESX.SetTimeout(msec, cb)
This function sets a timeout requiring two arguments, msec (milliseconds), and cb (callback).

local id = ESX.SetTimeout(5000, function()
    print('foo')
end)

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.ClearTimeout

ESX.ClearTimeout(id)
This function clears a timeout from the ESX.SetTimeout function.

local id = ESX.SetTimeout(5000, function()
  print('foo')
end)

ESX.ClearTimeout(id)

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.DumpTable

ESX.DumpTable(table)
This function dumps the given table to a readable string with a tree structure.

local myTable = { {esx = 'awesome'} }

local dumpedTable = ESX.DumpTable(myTable)

print(dumpedTable)

-- print below
{

  [1] = {

    ["esx"] = awesome,

  }

}

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.TableContainsValue

ESX.TableContainsValue(table, value)
This function searches a table and returns if the parsed value is found within.

local tableContent = { 'dude', 'esx' }

local foundValue = ESX.TableContainsValue(tableContent, 'esx') -- returns boolean

print(foundValue) -- returns true


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
============================================ Events ===========================================
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
 
esx:onPlayerDeath

AddEventHandler('esx:onPlayerDeath', function(data)

end)

data 
Table Information

child					type			explanation
--==========================================================================================================--
victimCoords			table	
killerCoords			table	
deathCause				string			Returns the hash of the weapon/model/object that killed the victim.
killedByPlayer			boolean			Was the player killed by another player? The data below is only generated when killed by a player.
distance				number			The distance (in GTA units) between the victim and killer upon death
killerServerId			number			The killers' server id
killerClientId			number			The killers' client id


--
== Example Server-Side Usage
--

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    data.victim = source

    if data.killedByPlayer then
        TriggerClientEvent('esx:showNotification', -1, GetPlayerName(data.victim) .. 'was killed by ' .. GetPlayerName(data.killerServerId) .. ' from ' .. data.distance .. ' units')
    else
        TriggerClientEvent('esx:showNotification', -1, GetPlayerName(data.victim) .. ' died')
    end
end)


--
== Example Client-Side Usage
--

local IsDead = false

AddEventHandler('esx:onPlayerDeath', function(data)
    IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
    IsDead = false
end)

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
---=========================================================================================---
=========================================== Client ============================================
---=========================================================================================---
--	
##			    	These functions can be used in only Client side code.
--	
-----------------------------------------------------------------------------------------------
========================================== Functions ==========================================
-----------------------------------------------------------------------------------------------

ESX.GetPlayerData

ESX.GetPlayerData()
This function gets player data.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.IsPlayerLoaded

ESX.IsPlayerLoaded()
This function checks if the player is loaded.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.SetPlayerData

ESX.SetPlayerData(key, val)
This function sets player data.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.ShowAdvancedNotification

ESX.ShowAdvancedNotification(title, subject, msg, icon, iconType)
This function shows an advanced notification. See Arguments Explained for an explanation of what each argument does.

ESX.ShowAdvancedNotification Example

function notification(msg)

  local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))

  ESX.ShowAdvancedNotification('title', 'subject', 'msg', mugshotStr, 1)

  UnregisterPedheadshot(mugshot)

end

Icon Types
1 Chat Box
2 Email
3 Add Friend Request
7 Right Jumping Arrow
8 RP Icon
9 $ Icon

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.ShowHelpNotification

ESX.ShowHelpNotification(msg)
This function shows a help notification with the parsed message. 
These help notification support displaying button inputs. 
See the list attached in the compilation.

ESX.ShowHelpNotification('Hit ~INPUT_CONTEXT~ to do shit!')

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.ShowInventory

ESX.ShowInventory()
This function shows the inventory.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.ShowNotification

ESX.ShowNotification(msg)
This function shows a basic notification to the player.

Supported Color Syntax
~r~ Red
~b~ Blue
~g~ Green
~y~ Yellow
~p~ Purple
~o~ Orange
~c~ Grey
~m~ Dark Grey
~u~ Black
~n~ New Line
~s~ White (Default)
~w~ White
~h~ Bold

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.TriggerServerCallback

ESX.TriggerServerCallback(name, cb, args)
This function triggers a server callback.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
===============================================================================================
-----------------------------------------------------------------------------------------------
--	
##			    		Client Functions - Sub Category - Game. (ESX.Game.)
--	
-----------------------------------------------------------------------------------------------
===============================================================================================
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.DeleteObject

ESX.Game.DeleteObject(object)
This function deletes an object.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.DeleteVehicle

ESX.Game.DeleteVehicle(vehicle)
This function deletes the parsed vehicle.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetClosestObject

ESX.Game.GetClosestObject(filter, coords)
This function gets the closest object.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetClosestPed

ESX.Game.GetClosestPed(coords, ignoreList)
This function gets the closest ped.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetClosestPlayer

ESX.Game.GetClosestPlayer(coords)
This function gets the closest player.

local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

if closestPlayer == -1 or closestDistance > 3.0 then
  ESX.ShowNotification('There\'s no players nearby!')
else
  ESX.ShowNotification('Don\'t get too close to ' .. GetPlayerName(closestPlayer))
end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetClosestVehicle

ESX.Game.GetClosestVehicle(coords)
This function gets the closest vehicle.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetObjects

ESX.Game.GetObjects()
This function gets objects.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetPedMugshot

local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))

This function generates a Mugshot of the current player usable in various applications.


function notification(msg)

  local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))

  ESX.ShowAdvancedNotification('Test', 'Testing!', msg, mugshotStr, 1)

  UnregisterPedheadshot(mugshot)

end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetPeds

ESX.Game.GetPeds(ignoreList)
This function gets peds.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetPlayers

ESX.Game.GetPlayers()
This function gets players.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetPlayersInArea

ESX.Game.GetPlayersInArea(coords, radius)
This function gets players in a given radius.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetVehicleInDirection

ESX.Game.GetVehicleInDirection()

This function gets the closest vehicle in the players
direction within 5 units, utilizes ray-casts.

local vehicle = ESX.Game.GetVehicleInDirection()

if DoesEntityExist(vehicle) then
  ESX.ShowNotification('yep there is a vehicle here!')
end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetVehicleProperties

ESX.Game.GetVehicleProperties(vehicle)
This function gets a vehicles properties.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetVehicles

ESX.Game.GetVehicles()
This function gets vehicles.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.GetVehiclesInArea

ESX.Game.GetVehiclesInArea(coords, radius)
This function gets vehicles in a given radius.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.IsSpawnPointClear

ESX.Game.IsSpawnPointClear(coords, radius)
Returns (boolean) if the spawn point coords area clear
 with no other vehicle in the parsed radius.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.SetVehicleProperties

ESX.Game.SetVehicleProperties(vehicle, props)
This function sets the properties for a vehicle.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.SpawnLocalObject

ESX.Game.SpawnLocalObject(modelOrHash, coords, cb)
This function spawns a local object, 
only visible to the local player and no one else.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.SpawnLocalVehicle

ESX.Game.SpawnLocalVehicle(modelOrHash, coords, heading, cb)
This function spawns a local vehicle, 
only visible to the local player and no one else.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.SpawnObject

ESX.Game.SpawnObject(modelOrHash, coords, cb)
This function spawns an object.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.SpawnVehicle

ESX.Game.SpawnVehicle(modelOrHash, coords, heading, cb)
This function spawns a vehicle.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Game.Teleport

ESX.Game.Teleport(entity, coords, cb)
This function teleports an entity.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
===============================================================================================
-----------------------------------------------------------------------------------------------
--	
##			    	Client Functions - Game.Sub Category - Utilities. (ESX.Game.Utils)
--	
-----------------------------------------------------------------------------------------------
===============================================================================================
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--ESX.Game.Utils.DrawText3D

--ESX.Game.Utils.DrawText3D(coords, text, size)

Los Oceanic Edit, 

ESX.Game.Utils.DrawText3D(x, y, z, text)
This function draws 3D text.


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

Los Oceanic Edit, 

ESX.Game.Utils.MiniMapPing

ESX.Game.Utils.MiniMapPing(x, y, z)
This function draws a ping on the minimap - Like robberies etc.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
===============================================================================================
-----------------------------------------------------------------------------------------------
--	
##			    	Client Functions - Sub Category - Scaleform. (ESX.Scaleform.)
--	
-----------------------------------------------------------------------------------------------
===============================================================================================
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Scaleform.ShowBreakingNews

ESX.Scaleform.ShowBreakingNews(title, msg, bottom, sec)
This function shows the 'Breaking News' scaleform used 
multiple times in the campaign.

The msg and bottom variables support HTML.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Scaleform.ShowFreemodeMessage

ESX.Scaleform.ShowFreemodeMessage(title, msg, sec)
This function displays a freemode message for the player.

ESX.Scaleform.ShowFreemodeMessage('~o~fact of the day', '~y~Hawaii is a king', 5)

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Scaleform.ShowPopupWarning

ESX.Scaleform.ShowPopupWarning(title, msg, bottom, sec)
This function shows a basic popup warning, like the quit confirmation warning.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Scaleform.ShowTrafficMovie

ESX.Scaleform.ShowTrafficMovie(sec)
This function starts the traffic scaleform movie used in the campaign.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Scaleform.Utils.RequestScaleformMovie

ESX.Scaleform.Utils.RequestScaleformMovie(movie)
This function requests and returns the scaleform movie parsed.

Here's a list of available scaleforms.

ESX.Scaleform.Utils.RequestScaleformMovie

local scaleform = ESX.ScaleForm.Utils.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
===============================================================================================
-----------------------------------------------------------------------------------------------
--	
##			    	Client Functions - Sub Category - Streaming. (ESX.Streaming.)
--	
-----------------------------------------------------------------------------------------------
===============================================================================================
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Streaming.RequestAnimDict

ESX.Streaming.RequestAnimDict(animDict, cb)
This function requests and returns the nimation directory parsed. 
A very common usage it to play animations using TaskPlayAnim(). 
You can use Alex Guirre's Animations List found on Github.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Streaming.RequestAnimSet

ESX.Streaming.RequestAnimSet(animSet, cb)
This function requests and returns the animation set parsed. 
Animation sets provide movement styles, commonly used with SetPedMovementClipset().

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Streaming.RequestModel

ESX.Streaming.RequestModel(model, cb)
This function requests and returns the specified model parsed, 
a very common usage is spawning objects, etc.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Streaming.RequestNamedPtfxAsset

ESX.Streaming.RequestNamedPtfxAsset(assetName, cb)

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Streaming.RequestStreamedTextureDict

ESX.Streaming.RequestStreamedTextureDict(textureDict, cb)
This function requests and returns the texture directory parsed. This is commonly used when loading sprites, 
then draw them on screen using DrawSprite(), 
an example would be drawing a speedometer.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Streaming.RequestWeaponAsset

ESX.Streaming.RequestWeaponAsset(weaponHash, cb)

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
===============================================================================================
-----------------------------------------------------------------------------------------------
--	
##			    	Client Functions - Sub Category - User Interface. (ESX.UI.)
--	
-----------------------------------------------------------------------------------------------
===============================================================================================
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.ShowInventoryItemNotification

ESX.UI.ShowInventoryItemNotification(add, item, count)
This function shows an inventory item notification.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.HUD.RegisterElement

ESX.UI.HUD.RegisterElement(name, index, priority, html, data)
This function registers a HUD element.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.HUD.RemoveElement

ESX.UI.HUD.RemoveElement(name)
This function removes a HUD element.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.HUD.SetDisplay

ESX.UI.HUD.SetDisplay(opacity)
This function sets the HUD opacity.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.HUD.UpdateElement

ESX.UI.HUD.UpdateElement(name, data)
This function updates HUD elements.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.Menu.Close

ESX.UI.Menu.Close(type, namespace, name)
This function closes a menu.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.Menu.CloseAll

ESX.UI.Menu.CloseAll()
This function closes all open menus.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.Menu.GetOpened

ESX.UI.Menu.GetOpened(type, namespace, name)
This function gets all opened menus.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.Menu.IsOpen

ESX.UI.Menu.IsOpen(type, namespace, name)
This function checks if a menu is open.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.Menu.Open

ESX.UI.Menu.Open(type, namespace, name, data, submit, cancel, change, close)
This function opens a menu.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UI.Menu.RegisterType

ESX.UI.Menu.RegisterType(type, open, close)
This function registers a menu type.

-----------------------------------------------------------------------------------------------
============================================ Events ===========================================
-----------------------------------------------------------------------------------------------

esx:playerLoaded

AddEventHandler('esx:playerLoader', function(xPlayer) end)

TriggerEvent('esx:playerLoaded', xPlayer)
Player loaded

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

esx:showAdvancedNotification

TriggerClientEvent('esx:showAdvancedNotification', source, title, subject, msg, icon, iconType)
This event shows a notification for the specified source. 
This is what you'll want to use server side when you want to send a notification.

TriggerClientEvent('esx:showAdvancedNotification', source, 'title', 'subject', 'msg', 'CHAR_AMMUNATION', 3)

Do not use this event for client side, instead use ESX.ShowAdvancedNotification


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

esx:showHelpNotification

TriggerClientEvent('esx:showHelpNotification', source, msg)
This event shows a help notification with the parsed message. 
These help notification support displaying button inputs.

TriggerClientEvent('esx:showHelpNotification', source, 'Hit ~INPUT_CONTEXT~ to do shit!')

Do not use this event for client side, instead use ESX.ShowHelpNotification

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

esx:showNotification

TriggerClientEvent('esx:showNotification', source, '~y~Hello ~b~world~s~!')
This event shows a basic notification to the player. 
This is what you'll want to use server side when you wan to send a notification.

Do not use this event for client side, instead use ESX.ShowHelpNotification

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
---=========================================================================================---
=========================================== Server ============================================
---=========================================================================================---
--	
##			    	These functions can be used in only Client side code.
--	
-----------------------------------------------------------------------------------------------
========================================== Functions ==========================================
-----------------------------------------------------------------------------------------------

ESX.CreatePickup

ESX.CreatePickup(type, name, count, label, player)
This function creates a pickup.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.GetItemLabel

ESX.GetItemLabel(item)
This function returns the item label.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.GetPlayerFromId

ESX.GetPlayerFromId(source)
This function gets a player from the ID.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.GetPlayerFromIdentifier

ESX.GetPlayerFromIdentifier(identifier)
This function gets a player from the identifier.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.GetPlayers

ESX.GetPlayers()
This function returns an array of all online players ID's.

You can use this to access each players data.

local xPlayers = ESX.GetPlayers()

for i=1, #xPlayers, 1 do

  local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

  if xPlayer.getName() == "Gepetto" then

    xPlayer.addMoney(100)

    TriggerClientEvent('esx:showNotification', xPlayer.source, "Blablabla...")

  end

end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.RegisterServerCallback

ESX.RegisterServerCallback(name, cb)
This function registers a server callback.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.RegisterUsableItem

ESX.RegisterUsableItem(item, cb)
This function registers a usable item.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.SavePlayer

ESX.SavePlayer(player, cb)
This function saves a player.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.SavePlayers

ESX.SavePlayers(cb)
This function saves players.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.Trace

ESX.Trace(str)
This function shows a debug line if Config.EnableDebug is true.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

ESX.UseItem

ESX.UseItem(source)
This function uses an item.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
---=========================================================================================---
=========================================== xPlayer ===========================================
---=========================================================================================---
--	
##			    	These functions can be used in only Server side code.
--	
-----------------------------------------------------------------------------------------------
========================================== Functions ==========================================
-----------------------------------------------------------------------------------------------

xPlayer.addAccountMoney

xPlayer.addAccountMoney(account, money)
This function adds account money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.addBank

xPlayer.addBank(money)
This function adds bank money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.addInventoryItem

xPlayer.addInventoryItem(item, count)
This function adds an inventory item.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.addMoney

xPlayer.addMoney(money)
This function adds money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.addWeapon

xPlayer.addWeapon(weaponName)
This function adds a weapon.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.addWeaponComponent

xPlayer.addWeaponComponent(weaponName, weaponComponent)
This function adds a weapon component to a weapon, if the player has it.

The available component list can be found in the weapon config file.

xPlayer.addWeapon('WEAPON_ASSAULTRIFLE', 50)
xPlayer.addWeaponComponent('WEAPON_ASSAULTRIFLE', 'clip_drum')
xPlayer.addWeaponComponent('WEAPON_ASSAULTRIFLE', 'flashlight')

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.displayBank

xPlayer.displayBank(money)
This function displays bank money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.displayMoney

xPlayer.displayMoney(money)
This function displays money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getAccount

xPlayer.getAccount()
This function gets an account.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getAccounts

xPlayer.getAccounts()
This function gets accounts.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getBank

xPlayer.getBank()
This function gets bank balance.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getCoords

xPlayer.getCoords()
This function gets coordinates.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getGroup

xPlayer.getGroup()
This function gets a group.
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getIdentifier

xPlayer.getIdentifier()
This function displays gets an identifier.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getInventory

xPlayer.getInventory()
This functions gets inventory.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getInventoryItem

xPlayer.getInventoryItem(item)
This function gets an inventory item.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getJob

xPlayer.getJob()
This function gets a job.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getLastPosition

xPlayer.getLastPosition()
This functins gets the last position of stuff.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getLoadout

xPlayer.getLoadout()
This function gets a loadout.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getMissingAccounts

xPlayer.getMissingAccounts()
This function gets missing accounts.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getMoney

xPlayer.getMoney()
This function gets money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getName

xPlayer.getName()
This function gets a name.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getPermissions

xPlayer.getPermissions()
This function gets a permission level.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getPlayer

xPlayer.getPlayer()
This function gets the EssentialMode player object.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getSessionVar

xPlayer.getSessionVar(key)
This function gets a session variable.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.getWeapon

xPlayer.getWeapon(weaponName)
This functions returns if the loadoutNum and a weapon object
 for the weapon if the player has it.

    local loadoutNum, weapon = xPlayer.getWeapon('WEAPON_PISTOL')

    if weapon then
        print(xPlayer.loadout[loadoutNum].label)
    else
        print('weapon not found!')
    end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.hasWeapon

xPlayer.hasWeapon(weaponName)
This functions returns if the player has the specified weapon.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.hasWeaponComponent

xPlayer.hasWeaponComponent(weaponName, weaponComponent)
This functions returns (boolean) if the player has the specified weapon component for a given weapon.

The available component list can be found in the weapon config file.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.kick

xPlayer.kick(reason)
This function kicks a player with a reason.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.removeAccountMoney

xPlayer.removeAccountMoney(account, money)
This function removes account money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
xPlayer.removeBank

xPlayer.removeBank(money)
This function removes bank money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.removeInventoryItem

xPlayer.removeInventoryItem(item, count)
This function removes an inventory item.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.removeMoney

xPlayer.removeMoney(money)
This function removes money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.removeWeapon

xPlayer.removeWeapon(weaponName, ammo)
This function removes a weapon from the player.

Warning

The ammo variable is optional to delete a certain amount of ammo. 
Not specifying it will remove all available ammo.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.removeWeaponComponent

xPlayer.removeWeaponComponent(weaponName, weaponComponent)
This function removes a weapon component from a player, if the player has it.

The available component list can be found in the weapon config file.

local weaponName, weaponComponent = 'WEAPON_PISTOL', 'clip_extended'

if xPlayer.hasWeaponComponent(weaponName, weaponComponent) then
    xPlayer.removeWeaponComponent(weaponName, weaponComponent)
end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.setAccountMoney

xPlayer.setAccountMoney(account, money)
This function sets account money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.setBankBalance

xPlayer.setBankBalance(money)
This function sets bank balance.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.setCoords

xPlayer.setCoords(x, y, z)
This function sets coordinates.
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.setInventoryItem

xPlayer.setInventoryItem(item, count)
This function sets an inventory item.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.setJob

xPlayer.setJob(name, grade)
This functions sets a job for a player.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.setMoney

xPlayer.setMoney(money)
This function sets money.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.setName

xPlayer.setName(newName)
This function sets the player name.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.setPermissions

xPlayer.setPermissions(permissionLevel)
This function sets a permission level.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

xPlayer.setSessionVar

xPlayer.setSessionVar(key, value)
This function sets a session variable.

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------