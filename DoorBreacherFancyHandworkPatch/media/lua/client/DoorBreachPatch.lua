--[[
    DoorBreacher & Fancy Handwork Compatibility Patch - Final Version
    Fixes all compatibility issues and adds sandbox option for knockdown
    Added: Reinforced door check and debug logging
    Fixed: Animation hardlock issue
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
    
    -- Helper function to check if door is reinforced
    local function isReinforcedDoor(door)
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
                    local numPlanks = barricade:getNumPlanks()
                    if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                        print("[DB+FH Patch] DEBUG: Door has barricade with " .. tostring(numPlanks) .. " planks")
                    end
                    if numPlanks and numPlanks > 0 then
                        return true
                    end
                end
            end
            return false
        end)
        
        if success and isBarricaded then
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: Door is barricaded")
            end
            return true
        end
        
        local sprite = door:getSprite()
        if sprite then
            local spriteName = sprite:getName()
            
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: Checking door sprite: " .. tostring(spriteName))
            end
            
            -- Check for specific metal door sprite numbers in fixtures_doors_01
            if spriteName then
                local spriteNum = string.match(spriteName, "fixtures_doors_01_(%d+)")
                if spriteNum then
                    spriteNum = tonumber(spriteNum)
                    if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                        print("[DB+FH Patch] DEBUG: Door sprite number: " .. spriteNum)
                    end
                    
                    -- Check against configured list of reinforced sprite numbers
                    local reinforcedNumbers = SandboxVars.DoorBreacher.ReinforcedSpriteNumbers or "32,33,34,35,36,37,38,39"
                    for numStr in string.gmatch(reinforcedNumbers, "(%d+)") do
                        local blockedNum = tonumber(numStr)
                        if spriteNum == blockedNum then
                            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                                print("[DB+FH Patch] DEBUG: Door is reinforced (sprite number matches blocked list)")
                            end
                            return true
                        end
                    end
                end
                
                -- Check sprite name for reinforced keywords
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
                        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                            print("[DB+FH Patch] DEBUG: Door is reinforced (sprite matched: " .. keyword .. ")")
                        end
                        return true
                    end
                end
            end
        end
        
        -- Try to check door properties safely
        local success, result = pcall(function()
            local properties = door:getProperties()
            if properties then
                if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                    print("[DB+FH Patch] DEBUG: Checking door properties")
                end
                
                -- Check material
                if properties.Val then
                    local material = properties:Val("Material")
                    if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                        print("[DB+FH Patch] DEBUG: Material: " .. tostring(material))
                    end
                    
                    if material and (material == "metal" or material == "Metal" or material == "steel" or material == "Steel") then
                        return true
                    end
                end
            end
            return false
        end)
        
        if success and result then
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: Door is reinforced (material is metal)")
            end
            return true
        end
        
        -- Try to check metal value safely
        if door.getMetalValue then
            local metalSuccess, metalValue = pcall(function()
                return door:getMetalValue()
            end)
            
            if metalSuccess and metalValue and metalValue > 0 then
                if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                    print("[DB+FH Patch] DEBUG: Door is reinforced (has metal value: " .. metalValue .. ")")
                end
                return true
            end
        end
        
        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
            print("[DB+FH Patch] DEBUG: Door is NOT reinforced")
        end
        
        return false
    end
    
    -- Completely override the original unsafe doBreachImpact function
    -- This replaces DoorBreacher.doBreachImpact globally
    DoorBreacher.doBreachImpact = function(door)
        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
            print("[DB+FH Patch] DEBUG: doBreachImpact called")
        end
        
        -- Check if knockdown is enabled via sandbox
        if not SandboxVars.DoorBreacher or not SandboxVars.DoorBreacher.EnableKnockdown then
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: Knockdown disabled, skipping impact")
            end
            return
        end
        
        if not door then 
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: No door for impact")
            end
            return 
        end
        
        local sq2 = door:getOppositeSquare()
        if not sq2 then 
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: No opposite square")
            end
            return 
        end
        
        local pl = getPlayer()
        if not pl then 
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: No player found")
            end
            return 
        end
        
        local movingObjects = sq2:getMovingObjects()
        if not movingObjects then 
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: No moving objects")
            end
            return 
        end
        
        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
            print("[DB+FH Patch] DEBUG: Processing " .. movingObjects:size() .. " moving objects")
        end
        
        -- Safely process each character
        for i=1, movingObjects:size() do
            local chr = movingObjects:get(i - 1)
            if chr then
                if SandboxVars.DoorBreacher.EnableDebugLog then
                    print("[DB+FH Patch] DEBUG: Found object at index " .. i)
                    print("[DB+FH Patch] DEBUG: Is IsoZombie: " .. tostring(instanceof(chr, "IsoZombie")))
                    print("[DB+FH Patch] DEBUG: Is IsoPlayer: " .. tostring(instanceof(chr, "IsoPlayer")))
                    print("[DB+FH Patch] DEBUG: ZedsKnockDown setting: " .. tostring(SandboxVars.DoorBreacher.ZedsKnockDown))
                    print("[DB+FH Patch] DEBUG: PlayersKnockDown setting: " .. tostring(SandboxVars.DoorBreacher.PlayersKnockDown))
                end
                
                local isFacing = false
                
                if instanceof(chr, "IsoZombie") and SandboxVars.DoorBreacher.ZedsKnockDown == true then
                    isFacing = chr:isFacingObject(door, 0.8)
                    
                    if SandboxVars.DoorBreacher.EnableDebugLog then
                        print("[DB+FH Patch] DEBUG: Found zombie, isFacing=" .. tostring(isFacing))
                        print("[DB+FH Patch] DEBUG: original_doKnockDown exists: " .. tostring(original_doKnockDown ~= nil))
                    end
                    
                    if original_doKnockDown then
                        original_doKnockDown(chr, isFacing)
                        if SandboxVars.DoorBreacher.EnableDebugLog then
                            print("[DB+FH Patch] DEBUG: Called original_doKnockDown")
                        end
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
                    
                    if SandboxVars.DoorBreacher.EnableDebugLog then
                        print("[DB+FH Patch] DEBUG: Found player, isFacing=" .. tostring(isFacing))
                    end
                    
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
        
        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
            print("[DB+FH Patch] DEBUG: doBreachImpact completed")
        end
    end
    
    -- Fixed perform function with reinforced door check
    function ISDoorBreacher:perform()
        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
            print("[DB+FH Patch] DEBUG: perform() called")
        end
        
        if not self.door then
            ISBaseTimedAction.perform(self)
            return
        end
        
        if not self.character then
            ISBaseTimedAction.perform(self)
            return
        end
        
        -- Check if door is reinforced
        if isReinforcedDoor(self.door) then
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                local sprite = self.door:getSprite()
                local spriteName = sprite and sprite:getName() or "unknown"
                print("[DB+FH Patch] DEBUG: Blocked breach attempt on reinforced door: " .. spriteName)
            end
            
            -- Very small chance (5%) to actually breach the reinforced door
            local luckyChance = ZombRand(100)
            if luckyChance < 5 then
                if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                    print("[DB+FH Patch] DEBUG: Lucky breach! Reinforced door opened!")
                end
                
                -- Check if door has barricade and remove it
                local success = pcall(function()
                    if self.door.getBarricadeForDoor then
                        local barricade = self.door:getBarricadeForDoor()
                        if barricade then
                            -- Remove the barricade
                            self.door:getSquare():transmitRemoveItemFromSquare(barricade)
                            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                                print("[DB+FH Patch] DEBUG: Removed barricade from door")
                            end
                        end
                    end
                end)
                
                -- Unlock and open the door
                self.door:setLockedByKey(false)
                self.door:ToggleDoor(self.character)
                getSoundManager():PlayWorldSound(self.door:getThumpSound(), self.door:getSquare(), 0, 5, 5, false)
                addSound(self.door, self.door:getX(), self.door:getY(), self.door:getZ(), 5, 1)
                
                -- Character is surprised it worked
                local surprisePhrases = {
                    "Whoa! It opened!",
                    "No way!",
                    "I can't believe that worked!",
                    "Lucky!",
                    "Holy crap!",
                    "That actually worked?"
                }
                self.character:Say(surprisePhrases[ZombRand(#surprisePhrases) + 1])
                
                -- Call knockdown if enabled
                if self.door and SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableKnockdown then
                    DoorBreacher.doBreachImpact(self.door)
                end
                
                ISBaseTimedAction.perform(self)
                return
            end
            
            -- Play failure sound
            getSoundManager():PlayWorldSound("MetalHit", self.door:getSquare(), 0, 5, 5, false)
            
            -- Random chance for fracture (30% chance)
            local reactChance = ZombRand(100)
            if reactChance < 30 then
                -- Try to play custom sound, fallback to vanilla
                local soundPlayed = false
                
                if self.character and self.character:getSquare() then
                    -- Try custom sound first
                    local customSound = "DoorBreacherFootInjury"
                    local success = pcall(function()
                        getSoundManager():PlayWorldSound(customSound, self.character:getSquare(), 0, 10, 10, false)
                        soundPlayed = true
                    end)
                    
                    if success and soundPlayed then
                        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                            print("[DB+FH Patch] DEBUG: Playing custom sound: " .. customSound)
                        end
                    else
                        -- Fallback to vanilla sound
                        getSoundManager():PlayWorldSound("BreakWoodItem", self.character:getSquare(), 0, 10, 10, false)
                        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                            print("[DB+FH Patch] DEBUG: Custom sound failed, using BreakWoodItem")
                        end
                    end
                end
                
                -- Apply fracture to foot
                local bodyDamage = self.character:getBodyDamage()
                if bodyDamage then
                    local footLeft = bodyDamage:getBodyPart(BodyPartType.Foot_L)
                    local footRight = bodyDamage:getBodyPart(BodyPartType.Foot_R)
                    local targetFoot = ZombRand(2) == 0 and footLeft or footRight
                    
                    if targetFoot then
                        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                            local footName = (targetFoot == footLeft) and "left" or "right"
                            print("[DB+FH Patch] DEBUG: Attempting to fracture " .. footName .. " foot")
                            print("[DB+FH Patch] DEBUG: Before - FractureTime: " .. tostring(targetFoot:getFractureTime()))
                        end
                        
                        -- Set fracture time (120 hours = 5 days)
                        targetFoot:setFractureTime(120)
                        
                        -- Add damage to make it more noticeable
                        targetFoot:AddDamage(10)
                        
                        -- Add pain
                        targetFoot:setAdditionalPain(50)
                        
                        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                            print("[DB+FH Patch] DEBUG: After - FractureTime: " .. tostring(targetFoot:getFractureTime()))
                            print("[DB+FH Patch] DEBUG: IsFractured: " .. tostring(targetFoot:getFractureTime() > 0))
                        end
                    end
                end
                
                -- Character swears about fracture
                local swearPhrases = {
                    "Ow! My foot!",
                    "Damn it!",
                    "That hurt!",
                    "Son of a...",
                    "I think I broke something!",
                    "Argh!",
                    "Stupid metal door!"
                }
                self.character:Say(swearPhrases[ZombRand(#swearPhrases) + 1])
            else
                -- Just blocked, no injury
                self.character:Say("This door is too reinforced!")
            end
            
            -- Stop and cancel the action
            ISBaseTimedAction.perform(self)
            return
        end
        
        local doorBreak = false
        local roll = ZombRand(1, 11)
        
        if roll > 5 then
            doorBreak = true
        end

        if doorBreak == true then
            -- IMPORTANT: Call knockdown BEFORE destroying door
            if self.door and SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableKnockdown then
                if SandboxVars.DoorBreacher.EnableDebugLog then
                    print("[DB+FH Patch] DEBUG: Calling doBreachImpact before door destruction")
                end
                DoorBreacher.doBreachImpact(self.door)
            end
            
            -- Save location data before destroying door
            local doorSquare = self.door:getSquare()
            local doorX = self.door:getX()
            local doorY = self.door:getY()
            local doorZ = self.door:getZ()
            
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: Door successfully breached and destroyed")
            end
            
            -- Destroy the door
            if isClient() then
                sledgeDestroy(self.door)
            else
                self.door:getSquare():transmitRemoveItemFromSquare(self.door)
            end
            
            -- Play sounds
            getSoundManager():PlayWorldSound("BreakObject", doorSquare, 0, 5, 5, false)
            addSound(self.character, doorX, doorY, doorZ, 15, 1)
            
            -- Clear door reference to prevent Fancy Handwork conflicts
            self.door = nil
        else
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: Door kicked open but not destroyed")
            end
            
            -- Unlock and open door (FIXED: was using undefined 'door' variable)
            self.door:setLockedByKey(false)
            
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: About to toggle door")
            end
            
            self.door:ToggleDoor(self.character)
            
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: Door toggled successfully")
            end
            
            getSoundManager():PlayWorldSound(self.door:getThumpSound(), self.door:getSquare(), 0, 5, 5, false)
            addSound(self.door, self.door:getX(), self.door:getY(), self.door:getZ(), 5, 1)
            
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: About to call doBreachImpact")
            end
            
            -- Only call impact if door still exists and knockdown is enabled
            if self.door and SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableKnockdown then
                DoorBreacher.doBreachImpact(self.door)
            end
            
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: After doBreachImpact call")
            end
        end
        
        ISBaseTimedAction.perform(self)
    end
    
    -- Fixed start function to prevent animation conflicts
    function ISDoorBreacher:start()
        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
            print("[DB+FH Patch] DEBUG: start() called")
        end
        
        if not self.character then 
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: No character in start()")
            end
            return 
        end
        
        -- Try to use original start if it exists and is safe
        if original_start and type(original_start) == "function" then
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: Calling original start()")
            end
            
            -- Use pcall to safely try original animation
            local success, err = pcall(function()
                original_start(self)
            end)
            
            if not success then
                if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                    print("[DB+FH Patch] DEBUG: Original start failed: " .. tostring(err))
                end
                -- Fallback: do nothing, let it play without specific animation
            else
                if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                    print("[DB+FH Patch] DEBUG: Original start succeeded")
                end
            end
        else
            if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
                print("[DB+FH Patch] DEBUG: No original start function, skipping animation")
            end
        end
    end
    
    function ISDoorBreacher:stop()
        if SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableDebugLog then
            print("[DB+FH Patch] DEBUG: stop() called")
        end
        
        if original_stop and type(original_stop) == "function" then
            original_stop(self)
        end
    end
    
    print("[DB+FH Patch] Patch applied successfully!")
end)