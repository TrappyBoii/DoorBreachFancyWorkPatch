--[[
    DoorBreacher Context Menu Patch
    Adds fresh context menu handler for barricaded doors
--]]

print("[Context Menu Patch] Loading...")

-- Create our own context menu handler
local function addBreachOption(player, context, worldobjects, test)
    -- Wrap everything in pcall for safety
    local success, err = pcall(function()
        print("[Context Menu Patch] addBreachOption called")
        
        local playerObj = getSpecificPlayer(player)
        if not playerObj then 
            print("[Context Menu Patch] No player object")
            return 
        end
        
        if not worldobjects then
            print("[Context Menu Patch] No worldobjects")
            return
        end
        
        -- Find door in worldobjects - try different iteration methods
        local door = nil
        
        -- Method 1: Try as Lua table with pairs
        print("[Context Menu Patch] Trying pairs iteration")
        for _, obj in pairs(worldobjects) do
            if obj and instanceof(obj, "IsoDoor") then
                door = obj
                print("[Context Menu Patch] Found door via pairs!")
                break
            end
        end
        
        -- Method 2: If that didn't work, try ipairs
        if not door then
            print("[Context Menu Patch] Trying ipairs iteration")
            for _, obj in ipairs(worldobjects) do
                if obj and instanceof(obj, "IsoDoor") then
                    door = obj
                    print("[Context Menu Patch] Found door via ipairs!")
                    break
                end
            end
        end
        
        -- Method 3: Try numeric indexing
        if not door then
            print("[Context Menu Patch] Trying numeric indexing")
            for i = 1, #worldobjects do
                local obj = worldobjects[i]
                if obj and instanceof(obj, "IsoDoor") then
                    door = obj
                    print("[Context Menu Patch] Found door via numeric index!")
                    break
                end
            end
        end
        
        if not door then 
            print("[Context Menu Patch] No door found")
            return 
        end
        
        -- Safely check if door is locked
        local isLocked = false
        if door.IsLocked and type(door.IsLocked) == "function" then
            isLocked = door:IsLocked()
        end
        
        print("[Context Menu Patch] Door locked: " .. tostring(isLocked))
        
        -- Check for barricade using multiple methods
        local isBarricaded = false
        
        -- Method 1: getBarricadeForDoor
        if door.getBarricadeForDoor and type(door.getBarricadeForDoor) == "function" then
            local barricade = door:getBarricadeForDoor()
            if barricade then
                isBarricaded = true
                print("[Context Menu Patch] Found barricade via getBarricadeForDoor")
            end
        end
        
        -- Method 2: getBarricade
        if not isBarricaded and door.getBarricade and type(door.getBarricade) == "function" then
            local barricade = door:getBarricade()
            if barricade then
                isBarricaded = true
                print("[Context Menu Patch] Found barricade via getBarricade")
            end
        end
        
        -- Method 3: isBarricaded
        if not isBarricaded and door.isBarricaded and type(door.isBarricaded) == "function" then
            isBarricaded = door:isBarricaded()
            print("[Context Menu Patch] Barricaded check via isBarricaded: " .. tostring(isBarricaded))
        end
        
        -- Method 4: DoorBreacher's function
        if not isBarricaded and DoorBreacher and DoorBreacher.isReinforcedOrBarricaded and type(DoorBreacher.isReinforcedOrBarricaded) == "function" then
            isBarricaded = DoorBreacher.isReinforcedOrBarricaded(door)
            print("[Context Menu Patch] Barricaded check via isReinforcedOrBarricaded: " .. tostring(isBarricaded))
        end
        
        print("[Context Menu Patch] Final - Locked: " .. tostring(isLocked) .. ", Barricaded: " .. tostring(isBarricaded))
        
        if not isLocked and not isBarricaded then
            print("[Context Menu Patch] Door not locked and not barricaded, exiting")
            return
        end
        
        -- Check if player has the key (don't show option if they do, unless door is barricaded)
        if isLocked and not isBarricaded then
            local hasKey = false
            if door.checkKeyId and type(door.checkKeyId) == "function" then
                local keyId = door:checkKeyId()
                if keyId and playerObj:getInventory():haveThisKeyId(keyId) then
                    hasKey = true
                end
            end
            
            if door.getKeyId and type(door.getKeyId) == "function" and not hasKey then
                local keyId = door:getKeyId()
                if keyId and playerObj:getInventory():haveThisKeyId(keyId) then
                    hasKey = true
                end
            end
            
            if hasKey then
                print("[Context Menu Patch] Player has key, exiting")
                return
            end
        end
        
        -- Check if it's a garage door (can't breach those)
        if door.getSprite and type(door.getSprite) == "function" then
            local sprite = door:getSprite()
            if sprite and sprite.getProperties and type(sprite.getProperties) == "function" then
                local props = sprite:getProperties()
                if props and props.Is and type(props.Is) == "function" then
                    if props:Is("GarageDoor") then
                        print("[Context Menu Patch] Garage door, exiting")
                        return
                    end
                end
            end
        end
        
        -- Add the breach option
        local optionText = "Breach Door"
        if isBarricaded then
            optionText = "Breach Barricaded Door"
        end
        
        print("[Context Menu Patch] Adding option: " .. optionText)
        
        if context and context.addOption and type(context.addOption) == "function" then
            context:addOption(optionText, playerObj, function(playerObj, door)
                if ISDoorBreacher then
                    ISTimedActionQueue.add(ISDoorBreacher:new(playerObj, door))
                else
                    print("[Context Menu Patch] ERROR: ISDoorBreacher not found!")
                end
            end, door)
        else
            print("[Context Menu Patch] ERROR: context.addOption not available")
        end
    end)
    
    if not success then
        print("[Context Menu Patch] ERROR in addBreachOption: " .. tostring(err))
    end
end

-- Register our handler
Events.OnFillWorldObjectContextMenu.Add(addBreachOption)

Events.OnGameBoot.Add(function()
    if not ISDoorBreacher then
        print("[Context Menu Patch] ERROR: ISDoorBreacher not found")
        return
    end
    
    -- Override isValid to remove strength requirement
    function ISDoorBreacher:isValid()
        if not self.door then return false end
        if not self.character then return false end
        
        -- Check for garage doors
        if self.spr then
            local props = self.spr:getProperties()
            if props and props:Is("GarageDoor") then 
                return false 
            end
        end
        
        -- Check if player has key (only block if not reinforced/barricaded)
        local keyId = self.door:checkKeyId() or self.door:getKeyId()
        if keyId and self.character:getInventory():haveThisKeyId(keyId) then
            if not (DoorBreacher.isReinforcedOrBarricaded and DoorBreacher.isReinforcedOrBarricaded(self.door)) then
                return false
            end
        end
        
        return true
    end
    
    print("[Context Menu Patch] Successfully patched!")
end)

print("[Context Menu Patch] Loaded - context menu handler registered")