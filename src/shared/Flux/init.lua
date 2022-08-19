local RunService = game:GetService("RunService")

local CONTROLLER_DEPTH = 4 -- how many controllers you've nested

local Promise = require(script.Promise)

local BaseController = require(script.BaseController)

local Matter = {
	Controllers = {};
}

function Matter.new(name: string, level: number, controller: table?): nil
	-- level 1 is first to load, and higher is later
	local NewController = BaseController.new(name, level)
	Matter.Controllers[name] = setmetatable(controller, {__index = NewController})
end

local function InitializeControllers()
	local InitializeFunctions = {}
	for Index, Controller in Matter.Controllers do
		InitializeFunctions[Index] = Promise.promisify(Controller._init)()
	end
	return Promise.all(InitializeFunctions)
end

local function ReadyControllers()
	local ReadyFunctions = {}
	for i = 1, CONTROLLER_DEPTH do
		for Name, Controller: BaseController.Controller in Matter.Controllers do
			if Controller.Level == i then
				table.insert(ReadyFunctions, Promise.promisify(Matter.Controllers[Name]._ready)())
			end
		end
	end

	return Promise.all(ReadyFunctions)
end

local function Render(dt: number)
	for _, Controller in Matter.Controllers do
		Controller._render(dt)
	end
end

local function Step(time: number, dt: number)
	for _, Controller in Matter.Controllers do
		Controller._step(time, dt)
	end
end

local function Beat(dt: number)
	for _, Controller in Matter.Controllers do
		Controller._beat(dt)
	end
end

-- run
function Matter.StartRunning()
	InitializeControllers()
	:andThen(function()
		return ReadyControllers()
	end)
	:andThen(function()
		RunService.RenderStepped:Connect(Render)
		RunService.Stepped:Connect(Step)
		RunService.Heartbeat:Connect(Beat)
	end)
	:catch(function(err)
		print("Something went wrong with the bootup process:\n", err)
	end)
end
-- end run

return Matter
