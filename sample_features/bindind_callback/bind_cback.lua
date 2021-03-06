-- GLOBAL --
_G.baseDir      = (...):match("(.-)[^%.]+$")
_G.engineDir      = _G.baseDir .. "engine."
_G.assetDir      = _G.baseDir .. "assets."
_G.componentDir   = _G.engineDir .. "baw.components.";

local Json = require("engine.json");

-- Link to lua callbacks
-- https://love2d.org/wiki/love

for callback_key, callback_value in pairs(callbacks) do
    love[callback_key] = function ()
        for action_key, action_value in ipairs(callback_value.actions) do
            if action_value.nsp == "global" then
                _G[action_value.id](action_value.arg)
            else
                -- ERROR HERE
                -- https://coldfix.de/2017/03/02/lua-argument-packing/
                love[action_value.nsp][action_value.id](action_value.args)
            end
        end
    end
end
