--!strict

local Memory = {}
local Settings = require(script.Settings)

-- Types
local Types = require(script.Parent.Types)
type Signature = Types.Signature

-- Services
local MessagingService = game:GetService("MessagingService")
local MemoryStoreService = game:GetService("MemoryStoreService")

-- Variables
local Storage = MemoryStoreService:GetSortedMap(Settings.identifierName)
local Previous = Storage:GetRangeAsync(Enum.SortDirection.Descending, Settings.memoryRange)
local Cache: { Signature } = {}

-- Initialize MemoryStore
for _, data in Previous do
	table.insert(Cache, data["value"])
end

-- Public Methods ------
function Memory:Queue(UID: Signature)
	Storage:SetAsync(
		tostring(DateTime.now().UnixTimestampMillis), 
		UID,
		Settings.memoryLifetime
	)
	MessagingService:PublishAsync(Settings.identifierName, UID)
end

function Memory:Search(UID: Signature): boolean
	local index = table.find(Cache, UID)
	return index and true or false
end

-- Listener
MessagingService:SubscribeAsync("catchr", function(message)
	table.insert(Cache, message.Data)
end)

return Memory