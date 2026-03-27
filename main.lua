Score16 = {}
Score16 = SMODS.current_mod

local files = {
    "src/functions.lua",
    "src/scoring_parameters.lua",
    "src/scoring_calculation.lua",
    "src/parameter_redirect.lua",
    "src/shader.lua",
    "src/edition_ownership.lua",
    "src/cheat_sheet.lua",
}

for _,file in ipairs(files) do
    assert(SMODS.load_file(file))()
end