export type Shard = {
	Name: string;
	Level: number;
	_init: () -> ();
	_ready: () -> ();
	_render: (dt: number) -> ();
	_step: (time: number, dt: number) -> ();
	_beat: (dt: number) -> ();
}

local Shard = {}

function Shard.new(name: string, level: number): Shard
	local NewController: Shard = {
		Name = name;
		Level = level;
		_init = function() end,
		_ready = function() end,
		_render = function(dt: number) end,
		_step = function(time: number, dt: number) end,
		_beat = function(dt: number) end,
	}
	return NewController
end

return Shard
