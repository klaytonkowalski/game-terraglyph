--------------------------------------------------------------------------------
-- PROPERTIES
--------------------------------------------------------------------------------

local p_utility = {}

--------------------------------------------------------------------------------
-- MODULE FUNCTIONS
--------------------------------------------------------------------------------

function p_utility.clamp(value, min_value, max_value)
	if value < min_value then
		return min_value
	end
	if value > max_value then
		return max_value
	end
	return value
end

function p_utility.wrap(value, min_value, max_value)
	local range = max_value - min_value
	if value < min_value then
		while value < min_value do
			value = value + range
		end
		return value
	end
	if value > max_value then
		while value > max_value do
			value = value - range
		end
		return value
	end
	return value
end

return p_utility