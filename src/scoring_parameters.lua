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
local optype = Score16.operator_types

Score16.parameters = {
    -- format
    -- {key = "", colour = HEX(...),
    sc16_clam = {
        key = "clam",
        colour = HEX('11FF11'),
        default_value = 0,
        calculation_keys = {
            clam = optype.additive_key(),
            x_clam = optype.multiplicative_key(),
            e_clam = optype.exponential_key(),
            eq_clam = optype.declarative_key(),
        }
    },
    sc16_wunk = {
        key = "wunk",
        colour = HEX('ff00ff'),
        default_value = 0,
        calculation_keys = {
            wunk = optype.additive_key(),
            x_wunk = optype.multiplicative_key(),
            e_wunk = optype.exponential_key(),
            eq_wunk = optype.declarative_key(),
        }
    }
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
