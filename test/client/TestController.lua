local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crystal = require(ReplicatedStorage.Shared.Crystal)
local Controllers = Crystal.Controllers

local Controller = {}

function Controller._init()
	print("test controller init")
end

function Controller._ready()
	print("test controller ready")
end

function Controller.Cross()
	print("test controller cross access")
end

return Controller
