local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crystal = require(ReplicatedStorage.Shared.Crystal)
local Shards = Crystal.Shards

local Shard = {}

function Shard._init()
	print("test controller2 init")
end

function Shard._ready()
	print("test controller2 ready")

	Shards.TC.Cross()
end

return Shard
