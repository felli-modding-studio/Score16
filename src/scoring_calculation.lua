local score16_matrix = {
    {"chips",     "mult",       "sc16_clam",      "sc16_wunk",},
    {"sc16_evil", "sc16_score", "sc16_stability", "sc16_lily",},
    {"sc16_none", "sc16_fuck",  "sc16_hyper",     "sc16_gender",},
    {"sc16_r",    "sc16_sun",   "sc16_horse",     "sc16_seven",},
}

local calc_params = Score16.table_keys(Score16.parameters)
table.insert(calc_params, 'mult')
table.insert(calc_params, 'chips')

SMODS.Scoring_Calculation {key = 'score16',
    parameters = calc_params,
    func = function(self, chips, mult, flames)
        local params = score16_matrix
        local matrix = {}
        for r,row in ipairs(params) do
            matrix[r] = {}
            for c,param_key in ipairs(row) do
                if param_key == "chips" then
                    matrix[r][c] = chips
                elseif param_key == "mult" then
                    matrix[r][c] = mult
                else
                    matrix[r][c] = SMODS.get_scoring_parameter(param_key, flames)
                end
                if type(matrix[r][c]) == "string" then return 0 end
            end
        end

        return Score16.determinant_4x(matrix)
    end,
    replace_ui = function (self) --[[@overload fun(self): table]]
        local params = score16_matrix

        local matrix_rows = {}
        for r,row in ipairs(params) do
            local row_cell_nodes = {}
            for c,param_key in ipairs(row) do
                row_cell_nodes[c] =
                {n=G.UIT.C, config={align = 'cm', id = 'hand_'..param_key..'_container'}, nodes = {
                    SMODS.GUI.score_container {
                        type = param_key,
                        align = 'cm',
                        w = 1,
                        h = 0.5,
                        scale = 0.2
                    }
                }}
                local node_container = row_cell_nodes[c].nodes[1]

                if param_key == "sc16_sun" then
                    local dynatext = node_container.nodes[3].config.object
                    dynatext.config.colours[1] = HEX('ffcc4d')
                end
            end

            matrix_rows[r] = {n=G.UIT.R, config = {align = "cm", padding = 0}, nodes = row_cell_nodes}
        end

        -- smods throws a fit without this because none of the operator gui stuff checks for nil
        table.insert(matrix_rows, SMODS.GUI.operator(0))

        return {n=G.UIT.R, config = {align = "cm"}, nodes=matrix_rows}
    end
}