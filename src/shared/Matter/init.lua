local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONTROLLER_DEPTH = 4 -- how many controllers you've nested

local Promise = require(script.Promise)

local Matter = {
	Controllers = {};
	__ControllerLevel = {}
}

export type BaseController = {
	_init: () -> ();
	_ready: () -> ();
	_process: (dt: number) -> ();
	_physics_process: (dt: number) -> ();
}

local function newController(): BaseController
	local NewBaseController: BaseController = {
		_init = function() end;
		_ready = function() end;
		_process = function(dt: number) end;
		_physics_process = function(dt: number) end;
	}

	return NewBaseController
end

function Matter.new(name: string, level: number, controller: table?): nil
	-- level 1 is first to load, and higher is later
	local NewController = newController()
	if not controller._init then
		controller._init = NewController._init
	end
	if not controller._ready then
		controller._ready = NewController._ready
	end
	if not controller._process then
		controller._process = NewController._process
	end
	if not controller._physics_process then
		controller._physics_process = NewController._physics_process
	end
	Matter.Controllers[name] = controller
	Matter.__ControllerLevel[name] = level
end

function Matter.InitializeControllers()
	local InitializeFunctions = {}
	for Index, Controller in pairs(Matter.Controllers) do
		InitializeFunctions[Index] = Promise.promisify(Controller._init)()
	end

	return Promise.all(InitializeFunctions)
end

function Matter.ReadyControllers()
	local ReadyFunctions = {}
	-- for Index, Controller in pairs(Matter.Controllers) do
	-- 	ReadyFunctions[Index] = Promise.promisify(Controller._ready)()
	-- end

	for i = 1, CONTROLLER_DEPTH do
		for Name, Level in Matter.__ControllerLevel do
			if not Level == i then
				continue
			end

			table.insert(ReadyFunctions, Promise.promisify(Matter.Controllers[Name]._ready)())
		end
	end

	return Promise.all(ReadyFunctions)
end

function Matter.ProcessControllers(dt: number)
	for _, Controller in pairs(Matter.Controllers) do
		Controller._process(dt)
	end
end

function Matter.PhysicsProcessControllers(dt: number)
	for _, Controller in pairs(Matter.Controllers) do
		Controller._physics_process(dt)
	end
end

-- run
function Matter.StartRunning()
	Matter.InitializeControllers()
	:andThen(function()
		return Matter.ReadyControllers()
	end)
	:andThen(function()
		RunService.RenderStepped:Connect(Matter.ProcessControllers)
		RunService.Stepped:Connect(Matter.PhysicsProcessControllers)
	end)
	:catch(function(err)
		print("Error initializing controllers: ", err)
	end)
end
-- end run

return Matter
