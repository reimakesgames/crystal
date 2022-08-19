local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crystal = require(ReplicatedStorage.Shared.Crystal)
local Controllers = Crystal.Controllers

local Controller = {}

function Controller._init()
	print("test controller2 init")
end

function Controller._ready()
	print("test controller2 ready")

	Controllers.TC.Cross()
end

return Controller
