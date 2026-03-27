-- Get a list of parameters that can actually be changed
local applicable_parameters = {}
for param_key, param_info in pairs(Score16.parameters) do
    for _ in pairs(param_info.calculation_keys) do
        -- This only runs if calculation_keys has anything
        table.insert(applicable_parameters, param_key)
        break
    end
end

-- Create the current run's list of parameter redirects.
---@return nil
function Score16.set_parameter_redirects()
    G.GAME.joker_param_redirects = {}
    for _,joker in ipairs(G.P_CENTER_POOLS.Joker) do
        local new_parameter = pseudorandom_element(applicable_parameters, 'sc16_param_redirect')
        G.GAME.joker_param_redirects[joker.key] = new_parameter
    end
end

-- Create the current run's selected row/column for Foil and Holographic.
---@return nil
function Score16.set_edition_targets()
    G.GAME.edition_targets = {}
    local editions = {"e_foil", "e_holo"}
    for _,edition_key in ipairs(editions) do
        G.GAME.edition_targets[edition_key] = {
            axis = pseudorandom('sc16_' .. edition_key .. '_axis') < 0.5 and "row" or "column",
            target = pseudorandom('sc16_' .. edition_key .. '_target', 1, 4)
        }
    end
end

-- Hook to create aforementioned redirects
local game_startrun_hook = Game.start_run
function Game:start_run(args)
	game_startrun_hook(self, args)
	if not args.savetext then
		Score16.set_parameter_redirects()
        Score16.set_edition_targets()
        SMODS.set_scoring_calculation('sc16_score16')
	end
end

-- Hook to perform actual redirection
local smods_calcindveffect = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if not from_edition and (effect.card or scored_card) then
        local card = effect.card or scored_card
        local card_key = card.config.center.key

        local new_parameter = G.GAME.joker_param_redirects[card_key]
        if new_parameter then
            local key_operator_type = Score16.calculation_key_types[key]
            local new_calc_key = Score16.parameters[new_parameter].calculation_keys[key_operator_type]

            key = new_calc_key
            -- as determinant_4x scales faster than chips x mult,
            -- halving amounts to bring score16 back down to balatro-like scaling
            amount = type(amount) == "number" and (amount/2) or amount
        end
    end
    return smods_calcindveffect(effect, scored_card, key, amount, from_edition)
end