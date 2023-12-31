local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widget.task-list')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')
local mat_icon_button = require('widget.material.icon-button')
local mat_icon = require('widget.material.icon')
local cpu_meter = require('widget.cpu.cpu-meter')
local ram_meter = require('widget.ram.ram-meter')
local temperature_meter = require('widget.temperature.temperature-meter')
local hardrive_meter = require('widget.harddrive.harddrive-meter')
local todo_widget = require('widget.todo-widget.todo')

local dpi = require('beautiful').xresources.apply_dpi

local icons = require('theme.icons')

-- Clock / Calendar 24h format
local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 9">%d.%m.%Y\n  %H:%M:%S</span>', 1)

-- Clock / Calendar 12AM/PM fornat
-- local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 9">%d.%m.%Y\n  %I:%M %p</span>\n<span font="Roboto Mono bold 9">%p</span>')
-- textclock.forced_height = 56

local clock = awful.widget.watch(
    "date +'%a %d %b %R:%S'", 1,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

-- Add a calendar (credits to kylekewley for the original code)
local month_calendar = awful.widget.calendar_popup.month({
  screen = s,
  start_sunday = false,
  week_numbers = true
})
month_calendar:attach(textclock)

local clock_widget = wibox.container.margin(textclock, dpi(13), dpi(13), dpi(8), dpi(8))

local meters = wibox.widget {
  require('widget.cpu.cpu-meter'),
  require('widget.ram.ram-meter'),
  require('widget.temperature.temperature-meter'),
  require('widget.harddrive.harddrive-meter'),
  require('widget.volume.volume-slider'),
  layout = wibox.layout.fixed.horizontal
}

local meters_widget = wibox.container.constraint(require('widget.cpu.cpu-meter'), 'max', 300)

local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))
add_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn(
          awful.screen.focused().selected_tag.defaultApp,
          {
            tag = _G.mouse.screen.selected_tag,
            placement = awful.placement.bottom_right
          }
        )
      end
    )
  )
)

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
  local layoutBox = clickable_container(awful.widget.layoutbox(s))
  layoutBox:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        3,
        function()
          awful.layout.inc(-1)
        end
      ),
      awful.button(
        {},
        4,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        5,
        function()
          awful.layout.inc(-1)
        end
      )
    )
  )
  return layoutBox
end

local TopPanel = function(s, offset)
  local offsetx = 0
  if offset == true then
    offsetx = dpi(48)
  end
  local panel =
    wibox(
    {
      ontop = true,
      screen = s,
      height = dpi(48),
      width = s.geometry.width - offsetx,
      x = s.geometry.x + offsetx,
      y = s.geometry.y,
      stretch = false,
      bg = beautiful.background.hue_800,
      fg = beautiful.fg_normal,
      struts = {
        top = dpi(48)
      }
    }
  )

  panel:struts(
    {
      top = dpi(48)
    }
  )

  local cpu_constraint = 120
  local ram_constraint = 230
  local temp_constraint = 130
  local hdd_constraint = 120
  local volume_constraint = 300
  local common_constraint = 300

  local tasks_layout = {}
  if s ~= screen.primary then
    tasks_layout =
      {
        layout = wibox.layout.fixed.horizontal,
        -- Create a taglist widget
        wibox.container.constraint(TaskList(s), 'max', s.geometry.width - common_constraint),
      }
  else
    tasks_layout =
      {
        layout = wibox.layout.fixed.horizontal,
        -- Create a taglist widget
        wibox.container.constraint(TaskList(s), 'max', s.geometry.width - cpu_constraint - ram_constraint - temp_constraint - hdd_constraint - volume_constraint - common_constraint),
    }
  end

  panel:setup {
    layout = wibox.layout.align.horizontal,
    tasks_layout,
    nil,
    {
      layout = wibox.layout.fixed.horizontal,
      {
        layout = awful.widget.only_on_screen,
        screen = "primary",
        {
          layout = wibox.layout.fixed.horizontal,
          wibox.container.constraint(require('widget.cpu.cpu-meter'), 'max', cpu_constraint),
          wibox.container.constraint(require('widget.ram.ram-meter'), 'max', ram_constraint),
          wibox.container.constraint(require('widget.temperature.temperature-meter'), 'max', temp_constraint),
          wibox.container.constraint(require('widget.harddrive.harddrive-meter'), 'max', hdd_constraint),
          wibox.container.constraint(require('widget.volume.volume-slider'), 'max', common_constraint),
          wibox.container.margin(todo_widget(), 10, 10),
        },
      },
      -- Clock
      clock_widget,
      -- Layout box
      LayoutBox(s)
    }
  }

  return panel
end

return TopPanel
