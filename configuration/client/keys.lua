local awful = require('awful')
require('awful.autofocus')
local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey

local clientKeys =
  awful.util.table.join(
  awful.key(
    {modkey},
    'f',
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = 'toggle fullscreen', group = 'client'}
  ),
  awful.key(
    {modkey, "Shift"},
    'c',
    function(c)
      c:kill()
    end,
    {description = 'close', group = 'client'}
  ),
  awful.key(
    {modkey, "Control"},
    "Return",
    function (c)
      c:swap(awful.client.getmaster())
    end,
    {description = "move to master", group = "client"}),
  awful.key(
    {modkey, "Shift"},
    "k",
    function ()
      awful.client.swap.byidx(  1)
    end,
    {description = "swap with next client by index", group = "client"}),
  awful.key(
    {modkey, "Shift"},
    "j",
    function ()
      awful.client.swap.byidx( -1)
    end,
    {description = "swap with previous client by index", group = "client"}),
  awful.key(
    {modkey, "Control"},
    "k",
    function ()
      awful.screen.focus_relative( 1)
    end,
    {description = "focus the next screen", group = "screen"}),
  awful.key(
    {modkey, "Control"},
    "j",
    function ()
      awful.screen.focus_relative(-1)
    end,
    {description = "focus the previous screen", group = "screen"})
)

return clientKeys
