
Plugin = {}
Plugin.__index = Plugin

local path_to_plugin_config = vim.fn.stdpath('config') .. '/lua/plugins' 

function Plugin:new(name)
  return setmetatable({
	  name = name,
	  packerConfig = {},
	  isEnabled = true
	},Plugin)
end

function Plugin:pack(config) 
  self.packerConfig = config
  return self
end

function Plugin:loadConfigFile()
  local configFile = path_to_plugin_config .. '/' .. self.name .. '.lua'
  local f = io.open(configFile,"r")
  if f~=nil then 
    --print("Loading plugin config file: " .. self.name)
    require("plugins." .. self.name) 
  else  
    --print("No config file found for: " .. self.name)
  end
end

function Plugin:enabled(yesno)
  self.isEnabled = yesno
  return self
end


