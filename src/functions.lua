-- Get the keys of a table in a list.
---@param tbl {string: any}
---@return string[]
function Score16.table_keys(tbl)
    local list = {}
    for key in pairs(tbl) do
        table.insert(list, key)
    end
    return list
end

-- Calculates the determinant of a 4x4 matrix.
---@param matx number[][]
---@return number
function Score16.determinant_4x(matx)
    --[[

    a b c d
    e f g h
    i j k l
    m n o p

    ]]

    -- r# = row #
    local r1, r2, r3, r4 = matx[1], matx[2], matx[3], matx[4]
    local a, b, c, d = r1[1], r1[2], r1[3], r1[4]
    local e, f, g, h = r2[1], r2[2], r2[3], r2[4]
    local i, j, k, l = r3[1], r3[2], r3[3], r3[4]
    local m, n, o, p = r4[1], r4[2], r4[3], r4[4]

    local det_A = i*n - m*j; local det_B = i*o - m*k; local det_C = i*p - m*l
    local det_D = j*o - n*k; local det_E = j*p - n*l
    local det_F = k*p - o*l

    return 0
    + a*( f*det_F - g*det_E + h*det_D )
    - b*( e*det_F - g*det_C + h*det_B )
    + c*( e*det_E - f*det_C + h*det_A )
    - d*( e*det_D - f*det_B + g*det_A )
end

function Score16.param_calc_effect(self, effect, scored_card, key, amount, from_edition)
	if not amount then return end
	if effect.card and effect.card ~= scored_card then juice_card(effect.card) end

	local key_effects = Score16.key_effects[self.key]
	if key_effects and key_effects[key] then
		local effect_values = key_effects[key](self.current, amount)
		if effect_values.identity and amount == effect_values.identity then return end

		self:modify(effect_values.apply - self.current)

		local status_text_target = effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus
		card_eval_status_text(status_text_target, 'extra', nil, percent, nil, effect[key .. "_message"] or {
			message = effect_values.message_key and localize{
				type = 'variable',
				key = effect_values.message_key,
				vars = {effect_values.message_text}
			} or effect_values.message_text,
			colour = self.colour,
			--[[sound = effect_values.sounds,]] -- do not add until sounds are figured out 
		})
		return true
	end
end