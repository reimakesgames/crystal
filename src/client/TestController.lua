local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Matter = require(ReplicatedStorage.Shared.Matter)
local Controllers = Matter.Controllers

local Module = {}

function Module._init()
	print("test controller init")
end

function Module._ready()
	print("test controller ready")
end

function Module.Cross()
	print("test controller cross access")
end

return Module
