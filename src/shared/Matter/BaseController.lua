export type BaseController = {
	_init: () -> ();
	_ready: () -> ();
	_render: (dt: number) -> ();
	_step: (time: number, dt: number) -> ();
	_beat: (dt: number) -> ();
}

local Controller = {}

function Controller.new(): BaseController
	local NewController = {}
	NewController._init = function() end
	NewController._ready = function() end
	NewController._render = function(dt: number) end
	NewController._step = function(time: number, dt: number) end
	NewController._beat = function(dt: number) end
	return NewController :: BaseController
end

return Controller
