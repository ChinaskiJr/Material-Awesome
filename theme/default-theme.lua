local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto medium 10'

-- Colors Pallets

-- Primary
theme.primary = mat_colors.deep_orange

-- custom icons
local icon_folder = "/usr/share/icons/Numix-Circle/48/apps/"

theme.ic_icons = {
  ["firefox"] = icon_folder .. "firefox.svg",
  ["Firefox"] = icon_folder .. "firefox.svg",
  ["Thunderbird"] = icon_folder .. 'thunderbird.svg',
  ["firefoxdeveloperedition"] = icon_folder .. "firefox-developer-edition.svg",
  ["Firefox Developer Edition"] = icon_folder .. "firefox-developer-edition.svg",
  ["Xfce4-terminal"] = icon_folder .. 'xfce-terminal.svg',
  ["jetbrains-phpstorm"] = icon_folder .. 'phpstorm.svg',
  ["Joplin"] = icon_folder .. 'joplin.svg',
  ["Slack"] = icon_folder .. 'slack.svg',
  ["Subl"] = icon_folder .. 'sublimetext.svg',
  ["Sublime_text"] = icon_folder .. 'sublimetext.svg',
  ["discord"] = icon_folder .. 'discord.svg',
  ["VSCodium"] = icon_folder .. 'vscodium.svg',
  ["Google-chrome"] = icon_folder .. 'google-chrome.svg',
  ["Filezilla"] = icon_folder .. 'filezilla.svg',
  ["Thunar"] = icon_folder .. 'thunar.svg',
}

-- Accent
theme.accent = mat_colors.pink

-- Background
theme.background = mat_colors.grey

local awesome_overrides =
  function(theme)
  theme.dir = os.getenv('HOME') .. '/.config/awesome/theme'

  theme.icons = theme.dir .. '/icons/'
  theme.wallpaper = theme.dir .. '/wallpapers/DarkCyan.png'
  --theme.wallpaper = '#e0e0e0'
  theme.font = 'Roboto medium 10'
  theme.title_font = 'Roboto medium 14'

  theme.fg_normal = '#ffffffde'

  theme.fg_focus = '#e4e4e4'
  theme.fg_urgent = '#CC9393'
  theme.bat_fg_critical = '#232323'

  theme.bg_normal = theme.background.hue_800
  theme.bg_focus = '#5a5a5a'
  theme.bg_urgent = '#3F3F3F'
  theme.bg_systray = theme.background.hue_800

  -- Borders

  theme.border_width = dpi(2)
  theme.border_normal = theme.background.hue_800
  theme.border_focus = theme.primary.hue_300
  theme.border_marked = '#CC9393'

  -- Menu

  theme.menu_height = dpi(16)
  theme.menu_width = dpi(160)

  -- Tooltips
  theme.tooltip_bg = '#232323'
  --theme.tooltip_border_color = '#232323'
  theme.tooltip_border_width = 0
  theme.tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(6))
  end

  -- Layout

  theme.layout_floating = theme.icons .. 'layouts/floatingw.png'
  theme.layout_tile = theme.icons .. 'layouts/tilew.png'
  theme.layout_tileleft = theme.icons .. 'layouts/tileleftw.png'
  theme.layout_tiletop = theme.icons .. 'layouts/tiletopw.png'
  theme.layout_tilebottom = theme.icons .. 'layouts/tilebottomw.png'

  -- Taglist

  theme.taglist_bg_empty = theme.background.hue_800
  theme.taglist_bg_occupied =
  'linear:0,0:' ..
    dpi(48) ..
      ',0:0,' ..
        theme.secondary.hue_500 ..
          ':0.08,' .. theme.secondary.hue_500 .. ':0.08,' .. theme.background.hue_800 .. ':1,' .. theme.background.hue_800
  theme.taglist_bg_urgent =
    'linear:0,0:' ..
    dpi(48) ..
      ',0:0,' ..
        theme.accent.hue_500 ..
          ':0.08,' .. theme.accent.hue_500 .. ':0.08,' .. theme.background.hue_800 .. ':1,' .. theme.background.hue_800
  theme.taglist_bg_focus =
    'linear:0,0:' ..
    dpi(48) ..
      ',0:0,' ..
        theme.primary.hue_500 ..
          ':0.08,' .. theme.primary.hue_500 .. ':0.08,' .. theme.background.hue_800 .. ':1,' .. theme.background.hue_800

  -- Tasklist

  theme.tasklist_font = 'Roboto medium 11'
  theme.tasklist_bg_normal = theme.background.hue_800
  theme.tasklist_bg_focus =
    'linear:0,0:0,' ..
    dpi(48) ..
      ':0,' ..
        theme.background.hue_800 ..
          ':0.95,' .. theme.background.hue_800 .. ':0.95,' .. theme.fg_normal .. ':1,' .. theme.fg_normal
  theme.tasklist_bg_urgent = theme.primary.hue_800
  theme.tasklist_fg_focus = '#DDDDDD'
  theme.tasklist_fg_urgent = theme.fg_normal
  theme.tasklist_fg_normal = '#AAAAAA'

  theme.icon_theme = 'Papirus-Dark'

  --Client
  theme.border_width = dpi(2)
  theme.border_focus = theme.primary.hue_500
  theme.border_normal = theme.background.hue_800
end
return {
  theme = theme,
  awesome_overrides = awesome_overrides
}
