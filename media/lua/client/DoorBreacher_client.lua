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


local Commands = {};
Commands.DoorBreacher = {};

-----------------------               ---------------------------
function DoorBreacher.doKnockDown(chr, isFacing)
	local isHitBehind = not isFacing
	if instanceof(chr, "IsoZombie") then
		chr:knockDown(isFacing)
	elseif instanceof(chr, "IsoPlayer") then
		chr:clearVariable("BumpFallType")
		if isFacing then
			chr:setBumpFallType("pushedBehind")
		else
			chr:setBumpFallType("pushedFront")
		end
		chr:setBumpType("stagger")
		chr:setVariable("BumpDone", false)
		chr:setVariable("BumpFall", true)
		chr:reportEvent("wasBumped")
	end
end

function DoorBreacher.doBreachImpact(door)
	local sq2 = door:getOppositeSquare()
	local pl =  getPlayer()
	for i=1, sq2:getMovingObjects():size() do
		local chr = sq2:getMovingObjects():get(i - 1)
		if chr then
			local isFacing = false
			if instanceof(chr, "IsoZombie") and SandboxVars.DoorBreacher.ZedsKnockDown == true then
				isFacing = chr:isFacingObject(door, 0.8) --or chr:isFacingLocation(door:getX(), door:getY(), door:getZ(), 0.8)
				DoorBreacher.doKnockDown(chr, isFacing)
				sendClientCommand('DoorBreacher', 'KnockDownZed', { id = pl:getOnlineID(), isFacing = isFacing, zedID = chr:getOnlineID(), })
			elseif instanceof(chr, "IsoPlayer") and SandboxVars.DoorBreacher.PlayersKnockDown == true then
				isFacing = chr:isFacingObject(door, 0.8) --or chr:isFacingLocation(door:getX(), door:getY(), door:getZ(), 0.8)
				DoorBreacher.doKnockDown(chr, isFacing)
				sendClientCommand('DoorBreacher', 'KnockDownPL', { id = pl:getOnlineID(), isFacing = isFacing, targID = chr:getOnlineID(), })
			end
		end
	end
end

function doDoorBreach(door, targSq)
	local pl = getPlayer(); if not pl then return end
	local caption = 'OPEN'
	local locked = door:isLocked()
	if isDebugEnabled() then
		if locked then
			caption = 'LOCKED'
			pl:setHaloNote(tostring(caption),250,50,50,100)
		end
		pl:setHaloNote(tostring(caption),150,250,150,100)
	end
	if locked then
		if luautils.walkAdj(pl, targSq) then
			ISTimedActionQueue.add(ISDoorBreacher:new(pl, door, door:getSprite()));
		end
	end
end


function DoorBreacher.findZedID(int)
	local zombies = getCell():getObjectList()
	for i=zombies:size(),1,-1 do
		local zed = zombies:get(i-1)
		if instanceof(zed, "IsoZombie") then
			local zedId=zed:getOnlineID()
			if zedId and zedId == int then return zed end
		end
	end
	return nil
end




Commands.DoorBreacher.KnockDownPL = function(args)
    local pl = getPlayer()
	local sender = getPlayerByOnlineID(tonumber(args.id))
    local targ = getPlayerByOnlineID(tonumber(args.targID))
    if targ and sender ~= pl then
		DoorBreacher.doKnockDown(targ, args.isFacing)
	end
end

Commands.DoorBreacher.KnockDownZed = function(args)
    local pl = getPlayer()
	local sender = getPlayerByOnlineID(tonumber(args.id))
	local zed = DoorBreacher.findZedID(tonumber(args.zedID))
    if zed and sender ~= pl then
		DoorBreacher.doKnockDown(zed, args.isFacing)
	end
end

Events.OnServerCommand.Add(function(module, command, args)
	if Commands[module] and Commands[module][command] then
		Commands[module][command](args)
	end
end)

--[[
function DoorBreacher.Collide(pl, door, sq, IsoThumpable, IsoWindow, zed)
	if instanceof(door, "IsoDoor")  then

		if pl == getPlayer()  then
			if isDebugEnabled() then
				local caption = 'OPEN'
				local locked = door:isLocked()
				if locked then
					caption = 'LOCKED'
					pl:setHaloNote(tostring(caption),150,250,150,900)
				end
				pl:setHaloNote(tostring(caption),150,250,150,900)
			end
		end
	end
end
Events.OnObjectCollide.Remove(DoorBreacher.Collide)
Events.OnObjectCollide.Add(DoorBreacher.Collide)


]]