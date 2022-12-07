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
	while value < min_value do
		value = value + range + 1
	end
	while value > max_value do
		value = value - range - 1
	end
	return value
end

function p_utility.swap(array, index_1, index_2)
	local element = array[index_2]
	array[index_2] = array[index_1]
	array[index_1] = element
end

return p_utility