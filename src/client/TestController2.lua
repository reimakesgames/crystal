local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Flux = require(ReplicatedStorage.Shared.Flux)
local Shards = Flux.Shards

local Shard = {}

function Shard._init()
	print("test controller2 init")
end

function Shard._ready()
	print("test controller2 ready")

	Shards.TC.Cross()
end

return Shard
