local RunService = game:GetService("RunService")
local IsServer = RunService:IsServer()
local IsClient = RunService:IsClient()

local Promise = require(script.Promise)

local BaseController = require(script.Shard)

local Crystal = {
	Controllers = {};
}

function Crystal.new(name: string, level: number, controller: table?): nil
	-- level 1 is first to load, and higher is later
	local NewController = BaseController.new(name, level)
	Crystal.Controllers[name] = setmetatable(controller, {__index = NewController})
end

local function FindHighestControllerLevel()
	local HighestLevel = 1
	for _, Controller in Crystal.Controllers do
		if Controller.Level > HighestLevel then
			HighestLevel = Controller.Level
		end
	end
	return HighestLevel
end

local function InitializeControllers()
	local InitializeFunctions = {}
	for Index, Controller in Crystal.Controllers do
		InitializeFunctions[Index] = Promise.promisify(Controller._init)()
	end
	return Promise.all(InitializeFunctions)
end

local function ReadyControllers()
	local ReadyFunctions = {}
	for i = 1, FindHighestControllerLevel() do
		for Name, Controller: BaseController.Type in Crystal.Controllers do
			if Controller.Level == i then
				table.insert(ReadyFunctions, Promise.promisify(Crystal.Controllers[Name]._ready)())
			end
		end
	end

	return Promise.all(ReadyFunctions)
end

local function Render(dt: number)
	for _, Controller in Crystal.Controllers do
		Controller._render(dt)
	end
end

local function Step(time: number, dt: number)
	for _, Controller in Crystal.Controllers do
		Controller._step(time, dt)
	end
end

local function Beat(dt: number)
	for _, Controller in Crystal.Controllers do
		Controller._beat(dt)
	end
end

-- run
function Crystal.Run()
	InitializeControllers()
	:andThen(function()
		return ReadyControllers()
	end)
	:andThen(function()
		if IsClient and not IsServer then
			RunService.RenderStepped:Connect(Render)
		end
		RunService.Stepped:Connect(Step)
		RunService.Heartbeat:Connect(Beat)
	end)
	:catch(function(err)
		print("Something went wrong with the bootup process:\n", err)
	end)
end
-- end run

return Crystal
