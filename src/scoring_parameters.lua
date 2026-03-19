Score16.operator_types = {
    additive_key = function (sound)
        return function (current, amount)
            return {
                identity = 0,
                apply = current + amount,
                message_key = amount > 0 and 'a_chips' or 'a_chips_minus',
                message_text = number_format(amount),
                sound = sound,
            }
        end
    end,
    multiplicative_key = function (sound)
        return function (current, amount)
            return {
                identity = 1,
                apply = current*amount,
                message_key = amount > 0 and 'a_chips' or 'a_chips_minus',
                message_text = 'X'..number_format(amount),
                sound = sound,
            }
        end
    end,
    exponential_key = function (sound)
        return function (current, amount)
            return {
                identity = 1,
                apply = current^amount,
                message_key = amount > 0 and 'a_chips' or 'a_chips_minus',
                message_text = '^'..number_format(amount),
                sound = sound,
            }
        end
    end,
    declarative_key = function (sound)
        return function (current, amount)
            return {
                identity = current,
                apply = amount,
                message_text = '='..number_format(amount),
                sound = sound,
            }
        end
    end,
}

local function default_calc_keys(key)
    return {
        [key] = Score16.operator_types.additive_key(),
        ['x_' .. key] = Score16.operator_types.multiplicative_key(),
        ['e_' .. key] = Score16.operator_types.exponential_key(),
        ['eq_' .. key] = Score16.operator_types.declarative_key(),
    }
end

Score16.parameters = {
    -- format
    -- {key = "", colour = HEX(...),
    sc16_clam = {
        key = "clam",
        colour = HEX('6cff75'),
        default_value = 0,
        calculation_keys = default_calc_keys("clam")
    },
    sc16_wunk = {
        key = "wunk",
        colour = HEX('e761fd'),
        default_value = 0,
        calculation_keys = default_calc_keys("wunk")
    },
    sc16_evil = {
        key = "evil",
        colour = HEX('fdeb6d'),
        default_value = 0,
        calculation_keys = default_calc_keys("evil")
    },
    sc16_score = {
        key = "score",
        colour = HEX('8303b2'),
        default_value = 1,
        calculation_keys = default_calc_keys("score")
    },
    sc16_stability = {
        key = "stability",
        colour = HEX('0300a9'),
        default_value = 0,
        calculation_keys = default_calc_keys("stability")
    },
    sc16_lily = {
        key = "lily",
        colour = HEX('ffb069'),
        default_value = 0,
        calculation_keys = default_calc_keys("lily")
    },
    sc16_none = {
        key = "none",
        colour = HEX('00000000'), -- eight 0s
        default_value = 0,
        calculation_keys = {}
    },
    sc16_fuck = {
        key = "fuck",
        colour = HEX('ff2b86'),
        default_value = 0,
        calculation_keys = default_calc_keys("fuck")
    },
    sc16_hyper = {
        key = "hyper",
        colour = HEX('1b3d3d'),
        default_value = 1,
        calculation_keys = default_calc_keys("hyper")
    },
    sc16_gender = {
        key = "gender",
        colour = HEX('ff9be3'),
        default_value = 0,
        calculation_keys = default_calc_keys("gender")
    },
    sc16_r = {
        key = "r",
        colour = HEX('903a3a'),
        default_value = 0,
        calculation_keys = default_calc_keys("r")
    },
    sc16_sun = {
        key = "sun",
        colour = HEX('f4900c'),
        default_value = 0,
        calculation_keys = default_calc_keys("sun")
    },
    sc16_horse = {
        key = "horse",
        colour = HEX('7f4812'),
        default_value = 0,
        calculation_keys = default_calc_keys("horse")
    },
    sc16_seven = {
        key = "seven",
        colour = HEX('02fffe'),
        default_value = 7,
        calculation_keys = {}
    },
}

for _,param in pairs(Score16.parameters) do
    SMODS.Scoring_Parameter {
        key = param.key,
        default_value = param.default_value,
        colour = param.colour,
        calculation_keys = Score16.table_keys(param.calculation_keys),
        calc_effect = Score16.param_calc_effect
    }
end
