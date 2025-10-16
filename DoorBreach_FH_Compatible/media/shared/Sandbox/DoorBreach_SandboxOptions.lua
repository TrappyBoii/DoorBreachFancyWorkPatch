-- DoorBreach_SandboxOptions.lua
-- Adds sandbox settings for the Door Breach (FancyHandwork Compatible) mod

require "Sandbox/SandboxOptions"

local optionGroup = SandboxOptions.instance and SandboxOptions.instance:addOptionGroup("DoorBreach_FH", "Door Breach (FancyHandwork Compatible)")

if optionGroup then
    optionGroup:addOption("DoorBreachStrengthReq", "Strength Requirement", 7, 1, 10, 1)
    optionGroup:addOption("DoorBreachSuccessChance", "Chance of Success (%)", 75, 0, 100, 5)
    optionGroup:addOption("DoorBreachInjuryChance", "Injury Chance on Failure (%)", 20, 0, 100, 5)
end

-- fallback if SandboxOptions.instance not yet created (for some SP contexts)
Events.OnInitSandboxOptions.Add(function()
    if SandboxVars.DoorBreach_FH == nil then SandboxVars.DoorBreach_FH = {} end
    SandboxVars.DoorBreach_FH.DoorBreachStrengthReq = SandboxVars.DoorBreach_FH.DoorBreachStrengthReq or 7
    SandboxVars.DoorBreach_FH.DoorBreachSuccessChance = SandboxVars.DoorBreach_FH.DoorBreachSuccessChance or 75
    SandboxVars.DoorBreach_FH.DoorBreachInjuryChance = SandboxVars.DoorBreach_FH.DoorBreachInjuryChance or 20
end)