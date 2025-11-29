Score16.parameters = {
    -- format
    -- {key = "", colour = HEX(...),  
}

for _,param in pairs(Score16.parameters) do
    SMODS.Scoring_Parameter {
        key = param.key,
        default_value = 1,
        colour = param.colour,

    }
end
