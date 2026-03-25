local mod_folder
for dir_name in Score16.path:gmatch("(.-)/") do mod_folder = dir_name end
local s16_img = love.graphics.newImage("Mods/" .. mod_folder .. "/assets/pattern_16.png")

-- needed in anticipation of future rearrangements
local param_to_num = {
    chips = 1,
    mult = 2,
    sc16_clam = 3,
    sc16_wunk = 4,
    sc16_evil = 5,
    sc16_score = 6,
    sc16_stability = 7,
    sc16_lily = 8,
    sc16_none = 9,
    sc16_fuck = 10,
    sc16_hyper = 11,
    sc16_gender = 12,
    sc16_r = 13,
    sc16_sun = 14,
    sc16_horse = 15,
    sc16_seven = 16,
}

SMODS.Shader {
    key = 'redir16',
    path = 'redir16.fs',
    send_vars = function (self, sprite, card)
        if not card then return end

        local card_param = G.GAME and G.GAME.joker_param_redirects and G.GAME.joker_param_redirects[card.config.center.key]
        if not card_param then return end

        return {
            aux_img = s16_img,
            aux_num = param_to_num[card_param]
        }
    end
}

SMODS.DrawStep {
    key = 'redir16_overlay',
    order = 20,
    func = function(self, layer)
        if (self.ability.set == 'Joker') then
            self.children.center:draw_shader('sc16_redir16', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}