local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Flux = require(ReplicatedStorage.Shared.Flux)

Flux.new("TC", 1, require(script.TestController))
Flux.new("TC2", 2, require(script.TestController2))

Flux.StartRunning()