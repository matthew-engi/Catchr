--!strict

local Autopen = {}

-- Services
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- Types
local Types = require(script.Parent.Types)
type Signature = Types.Signature

-- Dependencies
local SHA256 = require(script.SHA256)
local Builder = require(script.Builder)

-- Variables
local Cache: { [Player]: Signature } = {}

-- Listener ------------
if RunService:IsClient() then
	script.Identity.OnClientInvoke = function(): Signature
		local data: { [number]: any } = {}
		for i, identifier in pairs(Builder) do
			data[i] = identifier()
		end

		local Encoded = HttpService:JSONEncode(data)
		local Hashed = SHA256(buffer.fromstring(Encoded))

		return Hashed
	end

	return Autopen
end

-- Public Methods ------
function Autopen:SignClient(player: Player): Signature
	local UID: Signature = Cache[player] or script.Identity:InvokeClient(player)
	Cache[player] = UID
	return UID
end

return Autopen