--[[
    DoorBreacher & Fancy Handwork Compatibility Patch - Final Version
    Fixes all compatibility issues and adds sandbox option for knockdown
    Added: Reinforced door check and barricade removal
    Fixed: Animation hardlock issue
    Fixed: Barricade detection and removal
--]]

print("[DB+FH Patch] Loading final compatibility patch...")

Events.OnGameBoot.Add(function()
    if not ISDoorBreacher then
        print("[DB+FH Patch] ERROR: ISDoorBreacher not found")
        return
    end
    
    print("[DB+FH Patch] Applying fixes...")
    
    -- Save original functions
    local original_stop = ISDoorBreacher.stop
    local original_start = ISDoorBreacher.start
    local original_doBreachImpact = DoorBreacher.doBreachImpact
    local original_doKnockDown = DoorBreacher.doKnockDown
    
    -- Helper function to check if door is reinforced (non-local for export)
    function isReinforcedDoor(door)
        if not door then return false end
        
        -- Check if reinforced door blocking is enabled
        if not SandboxVars.DoorBreacher or not SandboxVars.DoorBreacher.BlockReinforcedDoors then
            return false
        end
        
        -- Check if door is barricaded
        local success, isBarricaded = pcall(function()
            if door.getBarricadeForDoor then
                local barricade = door:getBarricadeForDoor()
                if barricade then
                    if barricade.plankHealth then
                        for i = 0, 3 do
                            if barricade.plankHealth[i] and barricade.plankHealth[i] > 0 then
                                return true
                            end
                        end
                    end
                    if barricade.getNumPlanks then
                        local numPlanks = barricade:getNumPlanks()
                        if numPlanks and numPlanks > 0 then
                            return true
                        end
                    end
                end
            end
            if door.isBarricaded and door:isBarricaded() then
                return true
            end
            return false
        end)
        
        if success and isBarricaded then
            return true
        end
        
        local sprite = door:getSprite()
        if sprite then
            local spriteName = sprite:getName()
            if spriteName then
                local spriteNum = string.match(spriteName, "fixtures_doors_01_(%d+)")
                if spriteNum then
                    spriteNum = tonumber(spriteNum)
                    local reinforcedNumbers = SandboxVars.DoorBreacher.ReinforcedSpriteNumbers or "32,33,34,35,36,37,38,39"
                    for numStr in string.gmatch(reinforcedNumbers, "(%d+)") do
                        local blockedNum = tonumber(numStr)
                        if spriteNum == blockedNum then
                            return true
                        end
                    end
                end
                
                local reinforcedSpriteKeywords = {
                    "metal", "Metal", "METAL",
                    "industrial", "Industrial", "INDUSTRIAL",
                    "security", "Security", "SECURITY",
                    "steel", "Steel", "STEEL",
                    "vault", "Vault", "VAULT",
                    "prison", "Prison", "PRISON",
                    "jail", "Jail", "JAIL"
                }
                
                for _, keyword in ipairs(reinforcedSpriteKeywords) do
                    if string.find(spriteName, keyword) then
                        return true
                    end
                end
            end
        end
        
        local success, result = pcall(function()
            local properties = door:getProperties()
            if properties and properties.Val then
                local material = properties:Val("Material")
                if material and (material == "metal" or material == "Metal" or material == "steel" or material == "Steel") then
                    return true
                end
            end
            return false
        end)
        
        if success and result then
            return true
        end
        
        if door.getMetalValue then
            local metalSuccess, metalValue = pcall(function()
                return door:getMetalValue()
            end)
            
            if metalSuccess and metalValue and metalValue > 0 then
                return true
            end
        end
        
        return false
    end
    
    -- Helper function to properly remove barricade (FIXED VERSION)
    local function removeBarricade(door)
        if not door then 
            print("[DB+FH] removeBarricade: no door provided")
            return false
        end
        
        print("[DB+FH] Attempting to remove barricade...")
        
        local success, result = pcall(function()
            -- The barricade is a PROPERTY of the door, not a separate object
            -- We need to use the door's methods to remove it
            
            -- Method 1: Try to get and remove the barricade directly from the door
            if door.getBarricadeForDoor and type(door.getBarricadeForDoor) == "function" then
                print("[DB+FH] Trying getBarricadeForDoor...")
                local barricade = door:getBarricadeForDoor()
                
                if barricade then
                    print("[DB+FH] Found barricade, attempting to remove all planks...")
                    
                    -- Remove all planks one by one
                    if barricade.removePlank and type(barricade.removePlank) == "function" then
                        -- Get number of planks
                        local numPlanks = 0
                        if barricade.getNumPlanks and type(barricade.getNumPlanks) == "function" then
                            numPlanks = barricade:getNumPlanks()
                            print("[DB+FH] Barricade has " .. numPlanks .. " planks")
                        else
                            numPlanks = 4 -- Default to 4 if we can't get the count
                            print("[DB+FH] Assuming 4 planks (couldn't get count)")
                        end
                        
                        -- Remove all planks
                        for i = 1, numPlanks do
                            barricade:removePlank()
                            print("[DB+FH] Removed plank " .. i)
                        end
                    end
                    
                    -- Also try setting plank health to 0 directly
                    if barricade.plankHealth then
                        print("[DB+FH] Setting plank health to 0...")
                        for i = 0, 3 do
                            barricade.plankHealth[i] = 0
                        end
                    end
                    
                    -- Play destruction sound
                    local square = door:getSquare()
                    if square then
                        getSoundManager():PlayWorldSound("BreakWoodItem", square, 0, 5, 5, false)
                        print("[DB+FH] Played destruction sound")
                    end
                    
                    return true
                else
                    print("[DB+FH] getBarricadeForDoor returned nil")
                end
            else
                print("[DB+FH] getBarricadeForDoor method not available")
            end
            
            -- Method 2: Try getBarricade (alternative)
            if door.getBarricade and type(door.getBarricade) == "function" then
                print("[DB+FH] Trying getBarricade...")
                local barricade = door:getBarricade()
                
                if barricade then
                    print("[DB+FH] Found barricade via getBarricade")
                    
                    if barricade.removePlank and type(barricade.removePlank) == "function" then
                        for i = 1, 4 do
                            barricade:removePlank()
                            print("[DB+FH] Removed plank " .. i)
                        end
                    end
                    
                    if barricade.plankHealth then
                        for i = 0, 3 do
                            barricade.plankHealth[i] = 0
                        end
                    end
                    
                    local square = door:getSquare()
                    if square then
                        getSoundManager():PlayWorldSound("BreakWoodItem", square, 0, 5, 5, false)
                    end
                    
                    return true
                else
                    print("[DB+FH] getBarricade returned nil")
                end
            else
                print("[DB+FH] getBarricade method not available")
            end
            
            print("[DB+FH] No barricade found or already removed")
            return false
        end)
        
        if not success then
            print("[DB+FH] Error during barricade removal: " .. tostring(result))
            return false
        end
        
        return result
    end
    
    -- Override doBreachImpact function
    DoorBreacher.doBreachImpact = function(door)
        if not SandboxVars.DoorBreacher or not SandboxVars.DoorBreacher.EnableKnockdown then
            return
        end
        
        if not door then return end
        
        local sq2 = door:getOppositeSquare()
        if not sq2 then return end
        
        local pl = getPlayer()
        if not pl then return end
        
        local movingObjects = sq2:getMovingObjects()
        if not movingObjects then return end
        
        for i=1, movingObjects:size() do
            local chr = movingObjects:get(i - 1)
            if chr then
                local isFacing = false
                
                if instanceof(chr, "IsoZombie") and SandboxVars.DoorBreacher.ZedsKnockDown == true then
                    isFacing = chr:isFacingObject(door, 0.8)
                    if original_doKnockDown then
                        original_doKnockDown(chr, isFacing)
                    end
                    if isClient() then
                        sendClientCommand('DoorBreacher', 'KnockDownZed', { 
                            id = pl:getOnlineID(), 
                            isFacing = isFacing, 
                            zedID = chr:getOnlineID() 
                        })
                    end
                elseif instanceof(chr, "IsoPlayer") and SandboxVars.DoorBreacher.PlayersKnockDown == true then
                    isFacing = chr:isFacingObject(door, 0.8)
                    if original_doKnockDown then
                        original_doKnockDown(chr, isFacing)
                    end
                    if isClient() then
                        sendClientCommand('DoorBreacher', 'KnockDownPL', { 
                            id = pl:getOnlineID(), 
                            isFacing = isFacing, 
                            targID = chr:getOnlineID() 
                        })
                    end
                end
            end
        end
    end
    
    -- Override perform function
    function ISDoorBreacher:perform()
        print("[DB+FH] perform() called!")
        
        if not self.door then
            print("[DB+FH] perform: no door, exiting")
            ISBaseTimedAction.perform(self)
            return
        end
        
        if not self.character then
            print("[DB+FH] perform: no character, exiting")
            ISBaseTimedAction.perform(self)
            return
        end
        
        print("[DB+FH] perform: door and character exist, continuing...")
        
        -- IMPORTANT: Store barricade reference using the CORRECT method names
        local barricadeToRemove = nil
        
        -- Try getBarricadeForCharacter (correct method from docs)
        if self.door.getBarricadeForCharacter and type(self.door.getBarricadeForCharacter) == "function" then
            barricadeToRemove = self.door:getBarricadeForCharacter(self.character)
            print("[DB+FH] getBarricadeForCharacter: " .. tostring(barricadeToRemove))
        end
        
        -- Try getBarricadeOnSameSquare if first method didn't work
        if not barricadeToRemove and self.door.getBarricadeOnSameSquare and type(self.door.getBarricadeOnSameSquare) == "function" then
            barricadeToRemove = self.door:getBarricadeOnSameSquare()
            print("[DB+FH] getBarricadeOnSameSquare: " .. tostring(barricadeToRemove))
        end
        
        -- Try getBarricadeOnOppositeSquare as last resort
        if not barricadeToRemove and self.door.getBarricadeOnOppositeSquare and type(self.door.getBarricadeOnOppositeSquare) == "function" then
            barricadeToRemove = self.door:getBarricadeOnOppositeSquare()
            print("[DB+FH] getBarricadeOnOppositeSquare: " .. tostring(barricadeToRemove))
        end
        
        -- Check if door is reinforced
        local isReinforced = isReinforcedDoor(self.door)
        print("[DB+FH] Door is reinforced: " .. tostring(isReinforced))
        
        if isReinforced then
            print("[DB+FH] Handling reinforced door...")
            -- TESTING: 95% chance to breach
            local luckyChance = ZombRand(100)
            print("[DB+FH] Lucky chance roll: " .. luckyChance)
            
            if luckyChance < 5 then
                print("[DB+FH] Lucky! Attempting to breach...")
                
                -- Remove barricade if we have a reference
                if barricadeToRemove then
                    print("[DB+FH] Removing barricade...")
                    -- removePlank requires a character parameter
                    if barricadeToRemove.removePlank and type(barricadeToRemove.removePlank) == "function" then
                        local numPlanks = 4
                        if barricadeToRemove.getNumPlanks and type(barricadeToRemove.getNumPlanks) == "function" then
                            numPlanks = barricadeToRemove:getNumPlanks()
                        end
                        
                        print("[DB+FH] Removing " .. numPlanks .. " planks...")
                        for i = 1, numPlanks do
                            barricadeToRemove:removePlank(self.character)
                            print("[DB+FH] Removed plank " .. i .. "/" .. numPlanks)
                        end
                    end
                    
                    getSoundManager():PlayWorldSound("BreakWoodItem", self.door:getSquare(), 0, 5, 5, false)
                else
                    print("[DB+FH] No barricade reference to remove")
                end
                
                self.door:setLockedByKey(false)
                self.door:ToggleDoor(self.character)
                getSoundManager():PlayWorldSound(self.door:getThumpSound(), self.door:getSquare(), 0, 5, 5, false)
                addSound(self.door, self.door:getX(), self.door:getY(), self.door:getZ(), 5, 1)
                
                local surprisePhrases = {
                    "(surprised pikachu face)!",
                    "I can't believe that actually worked.!",
                    "That actually worked..?",
                    "Holy shit.",
                    "OH FUCK",
                    ":O"
                }
                self.character:Say(surprisePhrases[ZombRand(#surprisePhrases) + 1])
                
                if self.door and SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableKnockdown then
                    DoorBreacher.doBreachImpact(self.door)
                end
                
                ISBaseTimedAction.perform(self)
                return
            end
            
            getSoundManager():PlayWorldSound("MetalHit", self.door:getSquare(), 0, 5, 5, false)
            
            local reactChance = ZombRand(100)
            if reactChance < 30 then
                if self.character and self.character:getSquare() then
                    local success = pcall(function()
                        getSoundManager():PlayWorldSound("DoorBreacherFootInjury", self.character:getSquare(), 0, 10, 10, false)
                    end)
                    
                    if not success then
                        getSoundManager():PlayWorldSound("BreakWoodItem", self.character:getSquare(), 0, 10, 10, false)
                    end
                end
                
                local bodyDamage = self.character:getBodyDamage()
                if bodyDamage then
                    local footLeft = bodyDamage:getBodyPart(BodyPartType.Foot_L)
                    local footRight = bodyDamage:getBodyPart(BodyPartType.Foot_R)
                    local targetFoot = ZombRand(2) == 0 and footLeft or footRight
                    
                    if targetFoot then
                        targetFoot:setFractureTime(120)
                        targetFoot:AddDamage(10)
                        targetFoot:setAdditionalPain(50)
                    end
                end
                
                local swearPhrases = {
                    "[Internal Screaming]",
                    "SHIT MY FOOT!",
                    "AWFHH FUCK WHY DID I DO THAT?!",
                    "BITCH!",
                    "OH FUCK FUCK FUCK!",
                    "I THINK I BROKE MY FOOT!",
                    "AH FUCK!"
                }
                self.character:Say(swearPhrases[ZombRand(#swearPhrases) + 1])
            else
                self.character:Say("This door is too reinforced!")
            end
            
            ISBaseTimedAction.perform(self)
            return
        end
        
        local doorBreak = false
        local roll = ZombRand(1, 11)
        
        if roll > 5 then
            doorBreak = true
        end

        if doorBreak == true then
            if self.door and SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableKnockdown then
                DoorBreacher.doBreachImpact(self.door)
            end
            
            removeBarricade(self.door)
            
            local doorSquare = self.door:getSquare()
            local doorX = self.door:getX()
            local doorY = self.door:getY()
            local doorZ = self.door:getZ()
            
            if isClient() then
                sledgeDestroy(self.door)
            else
                self.door:getSquare():transmitRemoveItemFromSquare(self.door)
            end
            
            getSoundManager():PlayWorldSound("BreakObject", doorSquare, 0, 5, 5, false)
            addSound(self.character, doorX, doorY, doorZ, 15, 1)
            
            self.door = nil
        else
            removeBarricade(self.door)
            
            self.door:setLockedByKey(false)
            self.door:ToggleDoor(self.character)
            
            getSoundManager():PlayWorldSound(self.door:getThumpSound(), self.door:getSquare(), 0, 5, 5, false)
            addSound(self.door, self.door:getX(), self.door:getY(), self.door:getZ(), 5, 1)
            
            if self.door and SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableKnockdown then
                DoorBreacher.doBreachImpact(self.door)
            end
        end
        
        ISBaseTimedAction.perform(self)
    end
    
    -- Override isValid function
    function ISDoorBreacher:isValid()
        if not self.door then return false end
        if not self.character then return false end
        
        if self.spr then
            local props = self.spr:getProperties()
            if props and props:Is("GarageDoor") then return false end
        end
        
        local keyId = self.door:checkKeyId() or self.door:getKeyId()
        if self.character:getInventory():haveThisKeyId(keyId) then
            if not (DoorBreacher.isReinforcedOrBarricaded and DoorBreacher.isReinforcedOrBarricaded(self.door)) then
                return false
            end
        end
        
        if self.character:getPerkLevel(Perks.Strength) < 8 then return false end
        
        return true
    end
    
    -- Override start function
    function ISDoorBreacher:start()
        if not self.character then return end
        
        if original_start and type(original_start) == "function" then
            pcall(function()
                original_start(self)
            end)
        end
    end
    
    function ISDoorBreacher:stop()
        if original_stop and type(original_stop) == "function" then
            original_stop(self)
        end
    end
    
    print("[DB+FH Patch] Patch applied successfully!")
    
    DoorBreacher.isReinforcedOrBarricaded = isReinforcedDoor
end)