local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crystal = require(ReplicatedStorage.Shared.Crystal)
local Shards = Crystal.Shards

local Shard = {}

function Shard._init()
	print("test controller init")
end

function Shard._ready()
	print("test controller ready")
end

function Shard.Cross()
	print("test controller cross access")
end

return Shard
