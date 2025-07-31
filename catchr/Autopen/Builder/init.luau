--!strict

local Settings = require(script.Settings)

-- Services
local UserInputService = game:GetService("UserInputService")
local LocalizationService = game:GetService("LocalizationService")

-- Rounds a number to a given precision
local function round(x: number, precision: number)
	return math.round(x * 10^precision) / 10^precision
end

local Builder: { [number]: ( (...any) -> any ) } = {
	--[=[
		Returns an adjusted clock time based on client time and os.clock, 

	 	Reference:
		- https://create.roblox.com/docs/reference/engine/libraries/os#clock
	--]=]
	function(): number
		return round(
			tick() - os.clock(), 
			Settings.cpuClockPrecision
		)
	end,

	--[=[
		Returns true if the device has an accelerometer.

		Reference:
		- https://create.roblox.com/docs/reference/engine/classes/UserInputService#AccelerometerEnabled
	--]=]
	function(): boolean
		return UserInputService.AccelerometerEnabled
	end,

	--[=[
		Returns true if a keyboard is connected and usable.

		Reference:
		- https://create.roblox.com/docs/reference/engine/classes/UserInputService#KeyboardEnabled
	--]=]
	function(): boolean
		return UserInputService.KeyboardEnabled
	end,

	--[=[
		Returns true if touch input is supported on the device.

		Reference:
		- https://create.roblox.com/docs/reference/engine/classes/UserInputService#TouchEnabled
	--]=]
	function(): boolean
		return UserInputService.TouchEnabled
	end,

	--[=[
		Returns the current timezone offset as a string, in ±HHMM format.

		Reference:
		- https://create.roblox.com/docs/reference/engine/libraries/os#date
	--]=]
	function(): string
		return tostring(os.date("%z"))
	end,

	--[=[
		Returns true if the system is currently observing daylight savings time.

		Reference:
		- https://create.roblox.com/docs/reference/engine/libraries/os#date
	--]=]
	function(): boolean
		return os.date("*t").isdst
	end,

	--[=[
		Returns the current system locale ID of the user.

		Reference:
		- https://create.roblox.com/docs/reference/engine/classes/LocalizationService#SystemLocaleId
	--]=]
	function(): string
		return LocalizationService.SystemLocaleId
	end
}

return Builder
