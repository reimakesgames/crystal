local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Matter = require(ReplicatedStorage.Shared.Matter)

Matter.new("TC", 1, require(script.TestController))
Matter.new("TC2", 2, require(script.TestController2))

Matter.StartRunning()