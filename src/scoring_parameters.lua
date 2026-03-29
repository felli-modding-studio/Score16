Score16.calculation_types = {
    additive = {'chips', 'h_chips', 'chip_mod', 'mult', 'h_mult', 'mult_mod'},
    multiplicative = {	'x_chips', 'xchips', 'Xchip_mod', 'x_mult', 'Xmult', 'xmult', 'x_mult_mod', 'Xmult_mod',},
    exponential = {	'e_mult', 'emult', 'Emult_mod', 'e_chips', 'echips', 'Echip_mod',},
    declarative = {'eq_chips', 'eq_mult'},
}

Score16.calculation_key_types = {}

for type,calculation_keys in pairs(Score16.calculation_types) do
    for _,key in ipairs(calculation_keys) do
        Score16.calculation_key_types[key] = type
    end
end

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
        additive = key,
        multiplicative = 'x_' .. key,
        exponential = 'e_' .. key,
        declarative = 'eq_' .. key,
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
    sc16_paramscore = {
        key = "paramscore",
        colour = HEX('8303b2'),
        default_value = 1,
        calculation_keys = default_calc_keys("paramscore")
    },
    sc16_wicked = {
        key = "wicked",
        colour = HEX('0300a9'),
        default_value = 0,
        calculation_keys = default_calc_keys("wicked")
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

G.C.sc16_params = {}

for _,param in pairs(Score16.parameters) do
    SMODS.Scoring_Parameter {
        key = param.key,
        default_value = param.default_value,
        colour = param.colour,
        calculation_keys = Score16.table_keys(param.calculation_keys),
        calc_effect = Score16.param_calc_effect
    }

    G.C.sc16_params[param.key] = param.colour

    table.insert(SMODS.scoring_parameter_keys, param.calculation_keys.additive)
    table.insert(SMODS.scoring_parameter_keys, param.calculation_keys.multiplicative)
    table.insert(SMODS.scoring_parameter_keys, param.calculation_keys.exponential)
    table.insert(SMODS.scoring_parameter_keys, param.calculation_keys.declarative)
end

local lc_hook = loc_colour
function loc_colour(...)
    if not G.ARGS.LOC_COLOURS then lc_hook(...) end

    for key,colour in pairs(G.C.sc16_params) do
        G.ARGS.LOC_COLOURS[key] = colour
    end

    return lc_hook(...)
end