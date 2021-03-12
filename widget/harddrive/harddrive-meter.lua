local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local mat_slider = require('widget.material.slider')
local mat_icon = require('widget.material.icon')
local icons = require('theme.icons')
local watch = require('awful.widget.watch')
local dpi = require('beautiful').xresources.apply_dpi

local textbox =
  wibox.widget {
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox,
    font = 'Roboto medium 10',
  }

watch(
  [[bash -c "df -h /home|grep '^/' | awk '{print $5}'"]],
  10,
  function(_, stdout)
    local space_consumed = stdout:match('(%d+)')
    textbox:set_text(tonumber(space_consumed) .. '%')
    collectgarbage('collect')
  end
)

local harddrive_meter =
  wibox.widget {
  wibox.widget {
    icon = icons.harddisk,
    size = dpi(24),
    widget = mat_icon
  },
  textbox,
  widget = mat_list_item
}

return harddrive_meter
