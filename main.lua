Score16 = {}
Score16 = SMODS.current_mod

local files = {
    "src/functions.lua",
    "src/scoring_parameters.lua",
    "src/scoring_calculation.lua",
    "src/parameter_redirect.lua",
}

for _,file in ipairs(files) do
    assert(SMODS.load_file(file))()
end