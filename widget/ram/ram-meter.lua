local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local mat_slider = require('widget.material.slider')
local mat_icon = require('widget.material.icon')
local icons = require('theme.icons')
local watch = require('awful.widget.watch')
local dpi = require('beautiful').xresources.apply_dpi

--local slider =
--  wibox.widget {
--  read_only = true,
--  widget = mat_slider
--}
local textbox =
wibox.widget {
  align  = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
  font = 'Roboto medium 12',
}

watch(
  [[ bash -c "free | awk 'NR == 2 {printf \"%.2f\" \"% (\"\"%.2f\"\" Gb left)\", $3/$2*100, $4/1000000}'"]],
  1,
  function(_, stdout)
    -- There is a cariage return at the end of the string...
    -- awk is full of mystery
    textbox:set_text(stdout:sub(1, #stdout - 1))
    collectgarbage('collect')
  end
)

local ram_meter =
  wibox.widget {
  wibox.widget {
    icon = icons.chart,
    size = dpi(24),
    widget = mat_icon
  },
  textbox,
  widget = mat_list_item
}

return ram_meter
