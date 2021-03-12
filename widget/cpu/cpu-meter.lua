local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local mat_slider = require('widget.material.slider')
local mat_icon = require('widget.material.icon')
local icons = require('theme.icons')
local watch = require('awful.widget.watch')
local dpi = require('beautiful').xresources.apply_dpi

local total_prev = 0
local idle_prev = 0

--local slider =
--  wibox.widget {
--  read_only = true,
--  widget = mat_slider
--  }

local textbox =
  wibox.widget {
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox,
    font = 'Roboto medium 10',
  }

watch(
  [[bash -c "cat /proc/stat | grep '^cpu '"]],
  1,
  function(_, stdout)
    local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
      stdout:match('(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s')

    local total = user + nice + system + idle + iowait + irq + softirq + steal

    local diff_idle = idle - idle_prev
    local diff_total = total - total_prev
    local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10
    local rounded_diff_usage = math.floor(diff_usage + 0.5)

    textbox:set_text(rounded_diff_usage .. '%')

    total_prev = total
    idle_prev = idle
    collectgarbage('collect')
  end
)

local cpu_meter =
  wibox.widget {
  wibox.widget {
    icon = icons.memory,
    size = dpi(24),
    widget = mat_icon
  },
  textbox,
  widget = mat_list_item
}

return cpu_meter
