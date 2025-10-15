--[[
    DoorBreacher & Fancy Handwork Compatibility Patch - Final Version
    Fixes all compatibility issues and adds sandbox option for knockdown
--]]

print("[DB+FH Patch] Loading final compatibility patch...")

Events.OnGameBoot.Add(function()
    if not ISDoorBreacher then
        print("[DB+FH Patch] ERROR: ISDoorBreacher not found")
        return
    end
    
    print("[DB+FH Patch] Applying fixes...")
    
    local original_stop = ISDoorBreacher.stop
    
    -- Safe version of doBreachImpact with option to disable
    function DoorBreacher.doBreachImpact(door)
        -- Check if knockdown is enabled via sandbox
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
        
        -- Safely process each character
        for i=1, movingObjects:size() do
            local chr = movingObjects:get(i - 1)
            if chr then
                local isFacing = false
                
                if instanceof(chr, "IsoZombie") and SandboxVars.DoorBreacher.ZedsKnockDown == true then
                    isFacing = chr:isFacingObject(door, 0.8)
                    if DoorBreacher.doKnockDown then
                        DoorBreacher.doKnockDown(chr, isFacing)
                    end
                    sendClientCommand('DoorBreacher', 'KnockDownZed', { 
                        id = pl:getOnlineID(), 
                        isFacing = isFacing, 
                        zedID = chr:getOnlineID() 
                    })
                elseif instanceof(chr, "IsoPlayer") and SandboxVars.DoorBreacher.PlayersKnockDown == true then
                    isFacing = chr:isFacingObject(door, 0.8)
                    if DoorBreacher.doKnockDown then
                        DoorBreacher.doKnockDown(chr, isFacing)
                    end
                    sendClientCommand('DoorBreacher', 'KnockDownPL', { 
                        id = pl:getOnlineID(), 
                        isFacing = isFacing, 
                        targID = chr:getOnlineID() 
                    })
                end
            end
        end
    end
    
    -- Fixed perform function
    function ISDoorBreacher:perform()
        if not self.door then
            ISBaseTimedAction.perform(self)
            return
        end
        
        if not self.character then
            ISBaseTimedAction.perform(self)
            return
        end
        
        local doorBreak = false
        local roll = ZombRand(1, 11)
        
        if roll > 5 then
            doorBreak = true
        end

        if doorBreak == true then
            -- Save location data before destroying door
            local doorSquare = self.door:getSquare()
            local doorX = self.door:getX()
            local doorY = self.door:getY()
            local doorZ = self.door:getZ()
            
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
            -- Unlock and open door (FIXED: was using undefined 'door' variable)
            self.door:setLockedByKey(false)
            self.door:ToggleDoor(self.character)
            getSoundManager():PlayWorldSound(self.door:getThumpSound(), self.door:getSquare(), 0, 5, 5, false)
            addSound(self.door, self.door:getX(), self.door:getY(), self.door:getZ(), 5, 1)
            
            -- Only call impact if door still exists and knockdown is enabled
            if self.door and SandboxVars.DoorBreacher and SandboxVars.DoorBreacher.EnableKnockdown then
                DoorBreacher.doBreachImpact(self.door)
            end
        end
        
        ISBaseTimedAction.perform(self)
    end
    
    -- Keep original animation
    function ISDoorBreacher:start()
        if not self.character then return end
        self:setActionAnim("BreachDoor")
    end
    
    function ISDoorBreacher:stop()
        original_stop(self)
    end
    
    print("[DB+FH Patch] Patch applied successfully!")
end)