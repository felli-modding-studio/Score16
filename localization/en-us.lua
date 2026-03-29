return {
    descriptions = {
        Edition = {
            e_foil = {
                name = "Foil",
                text = {
                    "{C:attention}+#1# {}values in {C:attention}#2# #3# {}of",
                    "the parameter matrix",
                    "{C:inactive}(Target changes every run)"
                }
            },
            e_holo = {
                name = "Holographic",
                text = {
                    "{C:attention}X#1# {}values in {C:attention}#2# #3# {}of",
                    "the parameter matrix",
                    "{C:inactive}(Target changes every run)"
                }
            },
            e_polychrome = {
                name = "Polychrome",
                text = {
                    "{C:attention}X#1# {}values in the",
                    "{C:dark_edition}main diagonal {}of",
                    "the parameter matrix",
                }
            },
        },
        Other = {
            sc16_param_redirect = {
                name = "Parameter redirected",
                text = {
                    "This Joker instead",
                    "gives {C:attention}half {}of",
                    "{C:chips}Chips{}/{C:mult}Mult{} as {V:1}#1#",
                    "{C:inactive}(Changes every run)"
                }
            }
        }
    },
    misc = {
        dictionary = {
            sc16_chips = "Chips",
            sc16_mult = "Mult",
            sc16_clam = "Clams",
            sc16_wunk = "Wunk",
            sc16_evil = "EVIL",
            sc16_paramscore = "Score",
            sc16_wicked = "Wicked",
            sc16_lily = "Lily",
            sc16_none = "None",
            sc16_fuck = "Fuck",
            sc16_hyper = "Hyper",
            sc16_gender = "Gender",
            sc16_r = "R",
            sc16_sun = "Sun",
            sc16_horse = "Horse",
            sc16_seven = "7",

            k_row = "row",
            k_column = "column",
            k_row_column = "row/column",

            k_sc16_param_matrix = "Parameter Matrix",
            k_sc16_sorry_not_sorry = "(sorry not sorry)",
            b_sc16_cheat_sheet = "Cheat Sheet",
            b_sc16_simplify_definition = "Simplify definition",
            b_sc16_complicate_definition = "Complicate definition",
        },
        paragraphs = {
            determinant_explanation = {
                "The calculated score is the",
                "{C:attention}determinant {}of this 4x4 matrix,",
                "calculated with the following formula:",
            },
            determinant_explanation_simple = {
                "The calculated score is the",
                "{C:attention}determinant {}of this 4x4 matrix,",
                "which can be thought of as the",
                "hypervolume of the 4-dimensional",
                "hyper-parallellopiped with",
                "base edge coordinates defined",
                "by the matrix's columns."
            },
            visualize_4d = {
                "\"To deal with a 4-dimensional space,",
                "visualize a 3-D space and say",
                "'four' to yourself very loudly.",
                "Everyone does it.\"",
                "",
                "- {C:attention}Geoffrey Hinton"
            },
            main_diagonal = {
                "The {C:dark_edition}main diagonal {}goes",
                "from the {C:attention}top-left {}to the",
                "{C:attention}bottom-right {}of the matrix"
            },
        }
    }
}