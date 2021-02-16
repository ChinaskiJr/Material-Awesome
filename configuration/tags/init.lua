local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')

local tags = {
  {
    icon = icons.mdone,
    type = 'chrome',
    defaultApp = apps.default.browser,
  },
  {
    icon = icons.mdtwo,
    type = 'code',
    defaultApp = apps.default.editor,
  },
  {
    icon = icons.mdthree,
    type = 'social',
    defaultApp = apps.default.social,
  },
  {
    icon = icons.mdfour,
    type = 'game',
    defaultApp = apps.default.game,
  },
  {
    icon = icons.mdfive,
    type = 'vms',
    defaultApp = apps.default.game,
  },
  {
    icon = icons.mdsix,
    type = 'files',
    defaultApp = apps.default.files,
  },
  {
    icon = icons.mdseven,
    type = 'music',
    defaultApp = apps.default.music,
  },
  {
    icon = icons.mdheight,
    type = 'any',
    defaultApp = apps.default.rofi,
  }
}

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.floating,
}

awful.screen.connect_for_each_screen(
  function(s)
    if s.geometry.width >= s.geometry.height then
      layout = awful.layout.layouts[1]
    else
      layout = awful.layout.layouts[3]
    end
    for i, tag in pairs(tags) do
      awful.tag.add(
        i,
        {
          icon = tag.icon,
          icon_only = true,
          layout = layout,
          gap_single_client = false,
          gap = 4,
          screen = s,
          defaultApp = tag.defaultApp,
          selected = i == 1
        }
      )
    end
  end
)

_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = 4
    end
  end
)
