local awful = require('awful')
local gears = require('gears')
local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')

-- Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      keys = client_keys,
      buttons = client_buttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_offscreen,
      floating = false,
      maximized = false,
      above = false,
      below = false,
      ontop = false,
      sticky = false,
      maximized_horizontal = false,
      maximized_vertical = false
    }
  },
  {
    rule_any = {name = {'QuakeTerminal'}},
    properties = {skip_decoration = true}
  },
  -- Titlebars
  {
    rule_any = {type = {'dialog'}, class = {'Wicd-client.py', 'calendar.google.com'}},
    properties = {
      placement = awful.placement.centered,
      ontop = true,
      floating = true,
      drawBackdrop = true,
      shape = function()
        return function(cr, w, h)
          gears.shape.rounded_rect(cr, w, h, 8)
        end
      end,
      skip_decoration = true
    }
  },
  -- PhpStorm
  { rule = { class = "jetbrains-phpstorm", type = "dialog"},
    properties = {
      floating = true,
      screen = 2,
      maximized_vertical = true,
      maximized_horizontal = true,
    }
  },
  {
    rule = {
      class = "jetbrains-phpstorm",
      name="^win[0-9]+$"
    },
    properties = {
      placement = awful.placement.no_offscreen,
      titlebars_enabled = false
    }
  },

  -- AndroidStudio
  { rule = { class = "jetbrains-studio", type = "dialog"},
    properties = {
      floating = true,
      screen = 2,
      maximized_vertical = true,
      maximized_horizontal = true,
    }
  },
  { rule = { class = "jetbrains-studio", name="^win[0-9]+$"},
    properties = {
      placement = awful.placement.no_offscreen,
      titlebars_enabled = false
    }
  },
}
