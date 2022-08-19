local RunService = game:GetService("RunService")

local CONTROLLER_DEPTH = 4 -- how many controllers you've nested

local Promise = require(script.Promise)

local BaseController = require(script.BaseController)

local Matter = {
	Controllers = {};
	__ControllerLevel = {}
}

function Matter.new(name: string, level: number, controller: table?): nil
	-- level 1 is first to load, and higher is later
	Matter.Controllers[name] = setmetatable(controller, {__index = BaseController.new()})
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
			if Level == i then
				table.insert(ReadyFunctions, Promise.promisify(Matter.Controllers[Name]._ready)())
			end
		end
	end

	return Promise.all(ReadyFunctions)
end

function Matter.Render(dt: number)
	for _, Controller in pairs(Matter.Controllers) do
		Controller._render(dt)
	end
end

function Matter.Step(time: number, dt: number)
	for _, Controller in pairs(Matter.Controllers) do
		Controller._step(time, dt)
	end
end

function Matter.Beat(dt: number)
	for _, Controller in pairs(Matter.Controllers) do
		Controller._beat(dt)
	end
end

-- run
function Matter.StartRunning()
	Matter.InitializeControllers()
	:andThen(function()
		return Matter.ReadyControllers()
	end)
	:andThen(function()
		RunService.RenderStepped:Connect(Matter.Render)
		RunService.Stepped:Connect(Matter.Step)
		RunService.Heartbeat:Connect(Matter.Beat)
	end)
	:catch(function(err)
		print("Error initializing controllers: ", err)
	end)
end
-- end run

return Matter
