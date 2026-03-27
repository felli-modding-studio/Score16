local safe_loc = function(key)
    if key == "chips" then key = "sc16_chips"
    elseif key == "mult" then key = "sc16_mult"
    end
    return localize(key)
end

-- Matrix naming
local fake_score_container = function(args)
    -- Taken and modified from SMODS
    local scale = args.scale or 0.4
    local type = args.type
    local colour = args.colour or SMODS.Scoring_Parameters[type].colour
    local text = safe_loc(args.type)
    local text_colour = args.type == "sc16_sun" and HEX('ffcc4d') or G.C.UI.TEXT_LIGHT
    local w = args.w or 2
    local h = args.h or 1
    return
    {n=G.UIT.R, config={align = "cm", minw = w, minh = h, r = 0.1, colour = colour, id = 'hand_'..type..'_area', emboss = 0.05}, nodes={
        {n=G.UIT.T, config = {text = text, scale = scale*2.3, colour=text_colour, font=G.LANGUAGES['en-us'].font, shadow=true, float=true}},
    }}
end

local format_matrix_naming = function()
    local params = Score16.parameter_matrix

    local matrix_rows = {}
    for r,row in ipairs(params) do
        local row_cell_nodes = {}
        for c,param_key in ipairs(row) do
            row_cell_nodes[c] =
            {n=G.UIT.C, config={align = 'cm', id = 'hand_'..param_key..'_container'}, nodes = {
                fake_score_container {
                    type = param_key,
                    align = 'cm',
                    w = 1.75,
                    h = 0.5,
                    scale = 0.175
                }
            }}
        end
        matrix_rows[r] = {n=G.UIT.R, config = {align = "cm", padding = 0}, nodes = row_cell_nodes}
    end

    return {n=G.UIT.C, config = {align = "cm"}, nodes=matrix_rows}
end

-- Matrix determinant definition
local matrix_def_cache
local format_matrix_definition = function ()
    if matrix_def_cache then return matrix_def_cache end

    --[[
    + afkp + agln + ahjo
    - ahkn - agjp - aflo
    - bekp - celn - dejo
    + dekn + cejp + belo
    + bgip + chin + dflo
    - dgin - cfip - bhio
    - bglm - chjm - dfkm
    + dgjm + cflm + bhkm
    ]]

    local params = Score16.parameter_matrix
    local params_simple = Score16.parameter_matrix.simple
    local matx = {}
    for r,row in ipairs(params) do
        matx[r] = {}
        for c,param_key in ipairs(row) do
            local colour = param_key == "sc16_hyper" and "inactive" or params_simple[r][c]
            matx[r][c] = "{C:" .. colour .. "}" .. safe_loc(param_key)
        end
    end

    local r1, r2, r3, r4 = matx[1], matx[2], matx[3], matx[4]
    local a, b, c, d = r1[1], r1[2], r1[3], r1[4]
    local e, f, g, h = r2[1], r2[2], r2[3], r2[4]
    local i, j, k, l = r3[1], r3[2], r3[3], r3[4]
    local m, n, o, p = r4[1], r4[2], r4[3], r4[4]

    local matx_def_cols = {
        {n=G.UIT.C, nodes={}},
        {n=G.UIT.C, nodes={}},
        {n=G.UIT.C, nodes={}},
        {n=G.UIT.C, nodes={}},
        {n=G.UIT.C, nodes={}},
        {n=G.UIT.C, nodes={}},
    }
    local function term(variables)
        return ("%s{}*%s{}*%s{}*%s"):format(unpack(variables))
    end
    local function line(operator, term1, term2, term3)
        table.insert(matx_def_cols[1].nodes, Score16.UI.localize_line(operator))
        table.insert(matx_def_cols[2].nodes, Score16.UI.localize_line(term(term1)))
        table.insert(matx_def_cols[3].nodes, Score16.UI.localize_line(operator))
        table.insert(matx_def_cols[4].nodes, Score16.UI.localize_line(term(term2)))
        table.insert(matx_def_cols[5].nodes, Score16.UI.localize_line(operator))
        table.insert(matx_def_cols[6].nodes, Score16.UI.localize_line(term(term3)))
    end

    line("{} + ", {a,f,k,p}, {a,g,l,n}, {a,h,j,o})
    line("{} - ", {a,h,k,n}, {a,g,j,p}, {a,f,l,o})
    line("{} - ", {b,e,k,p}, {c,e,l,n}, {d,e,j,o})
    line("{} + ", {d,e,k,n}, {c,e,j,p}, {b,e,l,o})
    line("{} + ", {b,g,i,p}, {c,h,i,n}, {d,f,l,o})
    line("{} - ", {d,g,i,n}, {c,f,i,p}, {b,h,i,o})
    line("{} - ", {b,g,l,m}, {c,h,j,m}, {d,f,k,m})
    line("{} + ", {d,g,j,m}, {c,f,l,m}, {b,h,k,m})

    matrix_def_cache = {n=G.UIT.R, nodes=matx_def_cols}
    return matrix_def_cache
end

local matrix_definition_func = function()
    return
    {n=G.UIT.ROOT, config={colour=G.C.CLEAR}, nodes = {
        {n=G.UIT.R, config={padding=0.1,}, nodes={
            Score16.UI.localize_desc(G.localization.misc.paragraphs.determinant_explanation, {align="cm"}),
            format_matrix_definition()
        }},
    }}
end

local matrix_definition_simple_func = function ()
    return
    {n=G.UIT.ROOT, config={colour=G.C.CLEAR}, nodes = {
        {n=G.UIT.R, config={align="cm", padding=0.1}, nodes={
            {n=G.UIT.C, config={align="cm"}, nodes={
                Score16.UI.localize_desc(G.localization.misc.paragraphs.determinant_explanation_simple, {align="cm"})
            }},
            {n=G.UIT.C, config={minw=0.5, minh=0.01}},
            {n=G.UIT.C, config={align="cm"}, nodes={
                Score16.UI.localize_desc(G.localization.misc.paragraphs.visualize_4d, {align="cl"})
            }},
        }},
        {n=G.UIT.R, config={align="cm"}, nodes={
            {n=G.UIT.T, config={text=localize("k_sc16_sorry_not_sorry"), colour=G.C.JOKER_GREY, scale=0.3}}
        }}
    }}
end

G.FUNCS.change_definition = function(e)
    local definition_container = e.UIBox:get_UIE_by_ID("sc16_determinant_def")
    definition_container.config.mode = definition_container.config.mode == "complex" and "simple" or "complex"

    local change_def_button = e.UIBox:get_UIE_by_ID("sc16_definition_button")
    change_def_button.config.text = definition_container.config.mode == "complex" and localize("b_sc16_simplify_definition") or localize("b_sc16_complicate_definition")

    definition_container.config.object:remove()
    definition_container.config.object = UIBox {
        config = {parent = definition_container},
        definition = definition_container.config.mode == "complex" and matrix_definition_func() or matrix_definition_simple_func()
    }
    e.UIBox:recalculate()
end

Score16.UI.cheat_sheet = function()
    return
    {n=G.UIT.ROOT, config={colour=G.C.BLACK, r=0.5, padding=0.2}, nodes={
        {n=G.UIT.C, config={align="cm"}, nodes={
            -- Matrix definition
            {n=G.UIT.R, config={padding=0.05, align="cm",}, nodes={
                {n=G.UIT.R, config={padding=0.05, align="cm",}, nodes = {
                    {n=G.UIT.T, config={text=localize("k_sc16_param_matrix"), colour=G.C.UI.TEXT_LIGHT, scale=0.5}}
                }},
                {n=G.UIT.R, config={align="cm"}, nodes = {
                    format_matrix_naming(),
                    {n=G.UIT.C, config={align="cm", padding=0.1,}, nodes = {
                        Score16.UI.localize_desc(G.localization.misc.paragraphs.main_diagonal, {align="cm"})
                    }},
                }}
            }},
            -- Determinant definition
            {n=G.UIT.R, config={align="cm",},  nodes={
                {n=G.UIT.O, config={id="sc16_determinant_def", mode="complex", object = UIBox {
                    config = {},
                    definition = matrix_definition_func()
                }}}
            }},
            -- "Simplify definition" button
            {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0.1, r = 0.1, colour=G.C.ORANGE, button="change_definition", hover = true}, nodes={
                    {n=G.UIT.T, config={id = "sc16_definition_button", text = localize('b_sc16_simplify_definition'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                }}
            }}
        }},
    }}
end