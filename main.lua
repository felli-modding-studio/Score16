Score16 = {}
Score16 = SMODS.current_mod

local files = {
    -- "src/[].lua"
}

for _,file in ipairs(files) do
    assert(SMODS.load_file(file))()
end