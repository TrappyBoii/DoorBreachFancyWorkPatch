-- DoorBreachAction.lua
-- Breach Door action (configurable via sandbox). Compatible with Fancy Handwork.

require "TimedActions/ISBaseTimedAction"

DoorBreachAction = ISBaseTimedAction:derive("DoorBreachAction")

function DoorBreachAction:isValid()
    if not self.character or not self.door then return false end
    local req = SandboxVars.DoorBreach_FH and SandboxVars.DoorBreach_FH.DoorBreachStrengthReq or 7
    if self.character:getPerkLevel(Perks.Strength) < req then return false end
    return true
end

function DoorBreachAction:waitToStart()
    self.character:facePosition(self.door:getX(), self.door:getY())
    return self.character:shouldBeTurning()
end

function DoorBreachAction:update()
    self.character:facePosition(self.door:getX(), self.door:getY())
end

function DoorBreachAction:start()
    -- Duration based on strength
    local str = self.character:getPerkLevel(Perks.Strength)
    self.maxTime = 20 * 30 - (math.min(str, 10) * 30)
    self:setActionAnim("Loot")
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic)
end

function DoorBreachAction:perform()
    local successChance = SandboxVars.DoorBreach_FH and SandboxVars.DoorBreach_FH.DoorBreachSuccessChance or 75
    local injuryChance = SandboxVars.DoorBreach_FH and SandboxVars.DoorBreach_FH.DoorBreachInjuryChance or 20
    local roll = ZombRand(100)

    if roll < successChance then
        -- SUCCESS
        if instanceof(self.door, "IsoDoor") then
            local success = false
            pcall(function()
                if self.door.setDestroyed then
                    self.door:setDestroyed(true)
                    success = true
                elseif self.door.setIsDoorBroken then
                    self.door:setIsDoorBroken(true)
                    success = true
                elseif self.door.setBlocked then
                    self.door:setBlocked(true)
                    success = true
                elseif self.door.setDoorBroken then
                    self.door:setDoorBroken(true)
                    success = true
                end
            end)
            if not success then
                pcall(function()
                    self.door:setLocked(false)
                    self.door:setOpen(true)
                end)
            end
            if self.character:getEmitter() then
                self.character:getEmitter():playSound("WoodHitDoor")
            end
        end
    else
        -- FAILURE
        if ZombRand(100) < injuryChance then
            self.character:getBodyDamage():getBodyPart(BodyPartType.Foot_L):AddDamage(5)
            self.character:getBodyDamage():getBodyPart(BodyPartType.Foot_R):AddDamage(5)
            self.character:getEmitter():playSound("ZombieHit")
            self.character:Say("Ouch! That hurt!")
        else
            self.character:Say("The door held firm.")
        end
    end

    ISBaseTimedAction.perform(self)
end

function DoorBreachAction:new(character, door)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.door = door
    o.stopOnWalk = true
    o.stopOnRun = true
    o.maxTime = 20 * 30
    return o
end