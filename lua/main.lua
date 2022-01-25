local M = {}

function M.setup(config)
    local settings = require("settings")
    settings.load(config)
    settings.setup(config)
    --require("settings").setup(config)
end

return M
