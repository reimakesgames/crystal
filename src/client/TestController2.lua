local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Matter = require(ReplicatedStorage.Shared.Matter)
local Controllers = Matter.Controllers

local Module = {}

function Module._init()
	print("test controller2 init")
end

function Module._ready()
	print("test controller2 ready")

	Controllers.TC.Cross()
end

return Module
