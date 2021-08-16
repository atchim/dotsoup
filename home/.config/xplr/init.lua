version = '0.14.3'

local cfg = xplr.config
local g = cfg.general

g.enable_mouse = true
g.initial_layout = 'soupy'
g.show_hidden = false

cfg.layouts.custom.soupy = {Horizontal = {
	config = {constraints = {{Percentage = 75}, {Percentage = 25}}},
	splits = {'Table', 'Selection'},
}}
