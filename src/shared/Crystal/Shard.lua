export type Type = {
	Name: string;
	Level: number;
	_init: () -> ();
	_ready: () -> ();
	_render: (dt: number) -> ();
	_step: (time: number, dt: number) -> ();
	_beat: (dt: number) -> ();
}

local Controller = {}

function Controller.new(name: string, level: number): Type
	local NewController: Type = {
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

return Controller
