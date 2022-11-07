local event = {}

function event.trigger(id)
	local path = "/assets/events/event_" .. id .. ".json"
	local json_string = sys.load_resource(path)
	if json_string then
		local lua_table = json.decode(json_string)
		if lua_table then
			
		else
			print("Failed to decode json: " .. json_resource)
		end
	else
		print("Failed to load resource: " .. path)
	end
end

return event