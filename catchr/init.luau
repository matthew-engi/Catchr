--[=[
	🐈 catchr - Multi-Instance Detection Module
	─────────────────────────────────────────────
	Author: Matthew (Creaco) · License: License.luau
	Version: 1.0.0
	Last Updated: 2025-06-16

	Catchr provides developers with a straightforward way to detect:
		1. Clients using multiple accounts on the same device.
		2. Attempts to evade enforcement systems like BanAsync().
	
	All of this, while providing cross-server support, and for long-lasting periods.
		
	🔗 Inspired by:
		- https://github.com/raphtalia/RbxFingerprint
--]=]

--!strict

local catchr = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Dependencies
local Autopen = require(script.Autopen)
if RunService:IsClient() then return catchr end

local Signal = require(script.Signal)
local Memory = require(script.Memory)

-- Types 
local Types = require(script.Types)
type Signature = Types.Signature

-- Public Methods ------
function catchr:Register(player: Player)
	local UID: Signature = Autopen:SignClient(player)
	-- Store the UID in MemoryStoreService
	Memory:Queue(UID)
end

-- Public Signals -------
catchr.Flagged = Signal.new()

function catchr:Verify(player: Player): boolean
	local UID: Signature = Autopen:SignClient(player)
	local Signed: boolean = Memory:Search(UID)

	if Signed then
		catchr.Flagged:Fire(player)
	end
	
	return Signed
end

-- Listener -------------
Players.PlayerAdded:Connect(function(player)
	--This part is for automatic detection (Optional).
	catchr:Verify(player)
end)

return catchr