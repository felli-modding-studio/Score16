SMODS.Edition:take_ownership('e_foil', {
    config = {
        extra = {
            value = 10
        }
    },
    loc_vars = function (self, info_queue, card)
        local edition_def = (
            G.GAME
            and G.GAME.edition_targets
            and G.GAME.edition_targets[self.key]
            or {axis = "row_column", target = "1-4"}
        )

        return { vars = {
            card.edition.extra.value,
            localize("k_" .. edition_def.axis),
            edition_def.target
        } }
    end,
    calculate = function (self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            -- No need to check G.GAME, this only runs if that exists
            local edition_def = G.GAME.edition_targets[self.key]
            local axis = edition_def.axis
            local target = edition_def.target
            local params = Score16.get_nth[axis](Score16.parameter_matrix.simple, target)

            local ret_table = {}
            for _,param_key in ipairs(params) do
                ret_table[param_key] = card.edition.extra.value
            end

            return ret_table
        end
    end
})

SMODS.Edition:take_ownership('e_holo', {
    config = {
        extra = {
            value = 2
        }
    },
    loc_vars = function (self, info_queue, card)
        local edition_def = (
            G.GAME
            and G.GAME.edition_targets
            and G.GAME.edition_targets[self.key]
            or {axis = "row_column", target = "1-4"}
        )

        return { vars = {
            card.edition.extra.value,
            localize("k_" .. edition_def.axis),
            edition_def.target
        } }
    end,
    calculate = function (self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            local edition_def = G.GAME.edition_targets[self.key]
            local axis = edition_def.axis
            local target = edition_def.target
            local params = Score16.get_nth[axis](Score16.parameter_matrix.simple, target)

            local ret_table = {}
            for _,param_key in ipairs(params) do
                ret_table["x_" .. param_key] = card.edition.extra.value
            end

            return ret_table
        end
    end
})

SMODS.Edition:take_ownership('e_polychrome', {
    config = {
        extra = {
            value = 1.5
        }
    },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.edition.extra.value,} }
    end,
    calculate = function (self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            local params = Score16.get_diagonal(Score16.parameter_matrix.simple, "\\")

            local ret_table = {}
            for _,param_key in ipairs(params) do
                ret_table["x_" .. param_key] = card.edition.extra.value
            end

            return ret_table
        end
    end
})