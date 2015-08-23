-- Set up i2c
dofile('mcp23017.lua')

-- Load LED helpers
dofile('leds.lua')
-- Start linear animation
led_animate_bounce()

-- Connect to wifi
dofile('wifi.lua')

-- Set up telnet server
dofile('telnet.lua')
