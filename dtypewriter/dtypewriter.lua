----------------------------------------------------------------------
-- LICENSE
----------------------------------------------------------------------

-- MIT License

-- Copyright (c) 2022 Klayton Kowalski

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- https://github.com/klaytonkowalski/library-defold-typewriter

----------------------------------------------------------------------
-- PROPERTIES
----------------------------------------------------------------------

local dtypewriter = {}

local _container_node

local _font_id
local _font

local _text_raw
local _text_area_x
local _text_area_y
local _text_area_width

local _line_count_max
local _line_offset

local _chunks = {}

local _character_nodes = {}

local _colors = {}
local _default_color = vmath.vector4()

local _messages_toggle = false
local _messages_url

----------------------------------------------------------------------
-- CONSTANTS
----------------------------------------------------------------------

dtypewriter.messages =
{
	text_start = hash("text_start"),
	text_end = hash("text_end"),
	type = hash("type")
}

----------------------------------------------------------------------
-- LOCAL FUNCTIONS
----------------------------------------------------------------------

local function strip_spaces(text)
	local remove_consecutive_spaces = string.gsub(text, "%s+", " ")
	local remove_front_spaces = string.gsub(remove_consecutive_spaces, "^%s+", "")
	local remove_back_spaces = string.gsub(remove_front_spaces, "%s+$", "")
	local remove_br_spaces = string.gsub(remove_back_spaces, "%s*<br>%s*", "<br>")
	return remove_br_spaces
end

local function add_chunks(text)
	local start_index = 1
	local character_index = 1
	local color = _default_color
	while character_index <= #text do
		local character = string.sub(text, character_index, character_index)
		if character == " " then
			local chunk_1 = { text = string.sub(text, start_index, character_index - 1), color = color, content = true }
			_chunks[#_chunks + 1] = chunk_1
			local chunk_2 = { text = " ", color = color, space = true }
			_chunks[#_chunks + 1] = chunk_2
			start_index = character_index + 1
			character_index = character_index + 1
		elseif character == "<" then
			if string.sub(text, character_index, character_index + 6) == "<color=" then
				local color_start_index, color_end_index = string.find(text, "%l+", character_index + 7)
				local color_name = string.sub(text, color_start_index, color_end_index)
				color = _colors[color_name] or _default_color
				text = string.sub(text, 1, character_index - 1) .. string.sub(text, color_end_index + 2)
			elseif string.sub(text, character_index, character_index + 3) == "<br>" then
				local chunk_1 = { text = string.sub(text, start_index, character_index - 1), color = color }
				_chunks[#_chunks + 1] = chunk_1
				local chunk_2 = { br = true }
				_chunks[#_chunks + 1] = chunk_2
				start_index = character_index + 4
				character_index = character_index + 4
			end
		elseif character_index == #text then
			local chunk = { text = string.sub(text, start_index, character_index), color = color, content = true }
			_chunks[#_chunks + 1] = chunk
			character_index = character_index + 1
		else
			character_index = character_index + 1
		end
	end
end

local function set_transparent(color)
	return vmath.vector4(color.x, color.y, color.z, 0)
end

----------------------------------------------------------------------
-- MODULE FUNCTIONS
----------------------------------------------------------------------

function dtypewriter.init(container_node_id, font_id, text_area_x, text_area_y, text_area_width, line_count_max, line_offset)
	dtypewriter.clear()
	_container_node = gui.get_node(container_node_id)
	_font_id = font_id
	_font = gui.get_font_resource(font_id)
	_text_area_x = text_area_x
	_text_area_y = text_area_y
	_text_area_width = text_area_width
	_line_count_max = line_count_max
	_line_offset = line_offset
end

function dtypewriter.clear()
	_text_raw = nil
	_chunks = {}
	for _, node in pairs(_character_nodes) do
		gui.delete_node(node)
	end
	_character_nodes = {}
end

function dtypewriter.load(text)
	dtypewriter.clear()
	_text_raw = text
	text = strip_spaces(text)
	local text_metrics = resource.get_text_metrics(_font, text)
	local total_line_count = math.floor(text_metrics.width / (_text_area_width + 1) + 1)
	add_chunks(text)
	local line_width_remaining = _text_area_width
	local current_line = 1
	local next_character_x = _text_area_x
	for _, chunk in ipairs(_chunks) do
		local chunk_metrics = resource.get_text_metrics(_font, chunk.text or "")
		if line_width_remaining - chunk_metrics.width < 0 or chunk_metrics.width == 0 then
			line_width_remaining = _text_area_width
			current_line = current_line + 1
			next_character_x = _text_area_x
			if chunk.space then
				goto continue
			end
		end
		if chunk.text then
			for character in string.gmatch(chunk.text, ".") do
				local character_metrics = resource.get_text_metrics(_font, character)
				local position = vmath.vector3(next_character_x, -_text_area_y - (current_line - 1) * text_metrics.height + (current_line - 1) * _line_offset, 0)
				next_character_x = next_character_x + character_metrics.width + 1
				line_width_remaining = line_width_remaining - character_metrics.width - 1
				local character_node = gui.new_text_node(position, character)
				gui.set_parent(character_node, _container_node)
				gui.set_font(character_node, _font_id)
				gui.set_color(character_node, chunk.color)
				gui.set_adjust_mode(character_node, gui.ADJUST_FIT)
				gui.set_pivot(character_node, gui.PIVOT_NW)
				_character_nodes[#_character_nodes + 1] = character_node
			end
		end
		::continue::
	end
end

function dtypewriter.start()
	if _character_nodes > 0 then
		if _messages_toggle then
			msg.post(_messages_url, dtypewriter.messages.text_start)
		end
		-- todo
	end
end

function dtypewriter.set_color(name, color)
	_colors[name] = set_transparent(color)
end

function dtypewriter.set_default_color(color)
	_default_color = set_transparent(color)
end

function dtypewriter.clear_colors()
	_colors = {}
end

function dtypewriter.toggle_messages(flag)
	_messages_toggle = flag
end

function dtypewriter.set_messages_url(url)
	_messages_url = url
end

return dtypewriter