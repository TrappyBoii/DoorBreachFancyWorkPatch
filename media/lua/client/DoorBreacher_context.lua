--[[
----------------------------------------------------------------------------------------------------------------------------⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                       ⠀⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣰⣦⣀⣀⠀⠠⠄⠄⠠⠀⠀⢀⣠⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⡿⢿⣦⠀⠀⠀⠀⠀⠀⠀⢀⡷⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⣩⡿⠋⠙⠉⢩⡿⠟⠀⠀⠀⠀⠀⠀⢀⣶⣾⠟⠋⠛⣿⣷⡄⠀⠀⠀⠀⠀⣴⣿⠂⠀⠀⣼⡿⠀⠀⠀⠀⠀⠀⢀⣠⡴⠶⣤⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⠦⠤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⡿⠋⠀⢸⠏⠀⠀⠀⠀⠀⠀⠀⣼⠃⠀⠀⠀⠀⢠⡇⠀⠀⠀⢠⣾⠋⠀⠀⠀⠀⣸⠀⠀⠀⠀⠀⠀⠀⢠⣿⠋⠀⠀⠀⠀⠛⠛⠁⠀⠀⠀⢀⣾⣿⠏⠀⠀⢀⡿⠃⠀⠀⠀⠀⠀⠶⠋⠁⢀⣰⠟⠀⠀⠀⠀⠀⠀⠀⣹⣿⠀⠀⠀⠀⣨⣿⠇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣾⡟⢀⣠⣤⣴⣶⠆⠀⠀⠀⠀⠀⢰⠃⠀⠀⠀⠀⠀⣾⠀⠀⠀⣰⣿⠃⠀⠀⠀⠀⠀⣿⡀⠀⠀⠀⠀⠀⢀⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⠋⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⣠⣶⣯⣅⡀⠀⠀⠀⠀⠀⠀⠀⣿⡇⢀⣠⠴⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣸⡟⠀⠛⠉⣠⣾⠃⠀⠀⠀⠀⠀⠀⣼⠀⠀⠀⠀⠀⠀⢿⣤⡴⢺⢻⠃⠀⠀⠀⠀⠀⢸⡿⠁⠀⠀⠀⠀⠀⠀⢿⠀⠀⠀⠀⢀⣤⠀⠀⠀⠀⠀⢀⣿⣇⡤⠤⢤⣾⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢻⡆⠀⠀⠀⠀⠀⣿⣯⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⠃⠀⠀⢀⣼⠇⠀⠀⠀⠀⠀⠀⣰⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⢂⠇⠀⠀⠀⠀⠀⠀⣾⡅⠀⠀⠀⠀⠀⠀⠀⢸⣧⡀⠀⠀⣼⠇⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠐⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠃⠀⠀⠀⠀⠀⢰⡏⠘⣦⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠘⢧⣤⡶⠟⢻⠀⠀⠀⠀⠀⠀⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⢘⠏⠀⠀⠀⠀⠀⠀⢰⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣶⡾⠋⠀⠀⠀⠀⠀⠀⢸⡟⠀⠀⠀⢰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠞⠁⠀⠀⠀⠀⠀⠀⠁⠀⠈⠙⠂⠔⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠀⠀⠀⠀⠀⢀⣿⣤⠶⠒⠒⠁⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠐⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

----------------------------------------------------------------------------------------------------------------------------
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
Please contact me if you need to hire someone to do mods or other design related tasks
https://steamcommunity.com/id/glytch3r/myworkshopfiles/
https://ko-fi.com/glytch3r
Discord: Glytch3r#1337 / glytch3r


----------------------------------------------------------------------------------------------------------------------------
--]]

DoorBreacher = DoorBreacher or {}



function DoorBreacher.context(player, context, worldobjects, test)
    local pl = getSpecificPlayer(player)
	local sq = clickedSquare
	local zed = sq:getZombie()

	if sq then
		local caption = ''
		local door = nil
		for i=0, sq:getObjects():size()-1 do
			local obj = sq:getObjects():get(i)
			if obj and (instanceof(obj, "IsoDoor") or (instanceof(obj, "IsoThumpable") and obj:isDoor()))  then
				door = obj
				break
			end
		end
		if door  ~= nil  then
			local locked = door:isLocked()
			if locked then
				caption = 'LOCKED'
			end

			local optTip = context:addOptionOnTop('Breach Door', worldobjects, function()
				doDoorBreach(door, door:getSquare())
			end)

			local tip = ISWorldObjectContextMenu.addToolTip()

			tip:setName("Breach Door");
			tip.description = ""

			local bool = true
			if door:isBarricaded() then
				bool = false
				tip.description = tip.description.." Cannot Breach Barricaded Doors\n"
			end
			local props =  door:getSprite():getProperties()
			if (props and props:Is("GarageDoor")) then
				bool = false
				tip.description = tip.description.." Cannot Breach Garage Doors\n"
			end
			if pl:getPerkLevel(Perks.Strength) <= 7 then
				bool = false
				tip.description = tip.description.." Not Enough Strength Breach Doors\n"
			end
			if bool == false then
				optTip.notAvailable = true
				optTip.iconTexture = getTexture("media/ui/DoorBreacher_Cannot.png")
			else
				optTip.iconTexture = getTexture("media/ui/DoorBreacher_Breach.png")
				tip.description = "Breach Door"
			end
			optTip.toolTip = tip
			local keyId = door:checkKeyId() or door:getKeyId()
			if (keyId and pl:getInventory():haveThisKeyId(keyId)) or not door:isLocked() then
				context:removeOptionByName('Breach Door')
			end
		end
	end
end
Events.OnFillWorldObjectContextMenu.Remove(DoorBreacher.context)
Events.OnFillWorldObjectContextMenu.Add(DoorBreacher.context)

		--[[
			local optTip = context:addOption('Walk To Door', worldobjects, function()
				--print(sq:getDoor():isLocked())
				ISTimedActionQueue.add(ISDoorBreacher:new(pl, door))
			end)


			if pl:getPerkLevel(Perks.Strength) >= 7 then
				if DoorBreacher.isLockedDoor(door)  then
					if isAdmin() then
						local optTip = context:addOption('Admin Force Breach Door', worldobjects, function()
							local walk = ISWalkToTimedAction:new(pl, sq)
							ISTimedActionQueue.add(walk)
							ISTimedActionQueue.add(ISDoorBreacher:new(pl, door))
						end)
						optTip.iconTexture = getTexture("media/ui/DoorBreacher_Admin.png")
					end

					local optTip = context:addOption('Breach Door', worldobjects, function()
						local walk = ISWalkToTimedAction:new(pl, sq)
						ISTimedActionQueue.add(walk)
						ISTimedActionQueue.add(ISDoorBreacher:new(pl, door, 50))
					end)
					optTip.iconTexture = getTexture("media/ui/DoorBreacher_Breach.png")

					if door:isBarricaded() then
						local tip = ISWorldObjectContextMenu.addToolTip()
						tip.description = "Cannot Breach Barricaded Doors"
						optTip.notAvailable = true
						optTip.iconTexture = getTexture("media/ui/DoorBreacher_Barricaded.png")
						optTip.toolTip = tip
					end

					if door:getProperties():Is("forceLocked") then
						local tip = ISWorldObjectContextMenu.addToolTip()
						tip.description = "Unable To Breach Forced Locked Doors"
						optTip.notAvailable = true
						optTip.iconTexture = getTexture("media/ui/DoorBreacher_Safehouse.png")
						optTip.toolTip = tip
					end

					if door:getModData().CustomLock then
						local tip = ISWorldObjectContextMenu.addToolTip()
						tip.description = "Unable To Breach"
						optTip.notAvailable = true
						optTip.iconTexture = getTexture("media/ui/DoorBreacher_Cannot.png")
						optTip.toolTip = tip
					end

				else
					if DoorBreacher.isHasKey(door) then
						local optTip = context:addOption('Breach Door', worldobjects, function() end)
						local tip = ISWorldObjectContextMenu.addToolTip()
						tip.description = "Has Key"
						optTip.notAvailable = true
						optTip.iconTexture = getTexture("media/ui/DoorBreacher_HasKey.png")
						optTip.toolTip = tip
					else
						local optTip = context:addOption('Breach Door', worldobjects, function() end)
						local tip = ISWorldObjectContextMenu.addToolTip()
						tip.description = "Unlocked Door"
						optTip.notAvailable = true
						optTip.iconTexture = getTexture("media/ui/DoorBreacher_Unlocked.png")
						optTip.toolTip = tip
					end
				end
			else
				if DoorBreacher.isLockedDoor(door)  then
					if isAdmin() then
						local optTip = context:addOption('Admin Force Breach Door', worldobjects, function()
							--ISTimedActionQueue.add(ISWalkToTimedAction:new(pl, sq))
							if luautils.walkAdjWindowOrDoor(pl, sq) then
								ISTimedActionQueue.add(ISDoorBreacher:new(pl, door));
							end
						end)
						optTip.iconTexture = getTexture("media/ui/DoorBreacher_Admin.png")
					else
						local optTip = context:addOption('Breach Door', worldobjects, function() end)
						local tip = ISWorldObjectContextMenu.addToolTip()
						tip.description = "Not Enough Strength"
						optTip.notAvailable = true
						optTip.iconTexture = getTexture("media/ui/DoorBreacher_Cannot.png")
						optTip.toolTip = tip
					end
				end
			end
		end]]
