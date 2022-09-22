local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crystal = require(ReplicatedStorage.Shared.Crystal)

Crystal.new("TC", 1, require(script.TestController))
Crystal.new("TC2", 2, require(script.TestController2))

Crystal.Run()
