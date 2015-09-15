-- Set up i2c
dofile('mcp23017.lua')

-- Load LED helpers
dofile('leds.lua')

-- Motion detection
dofile('motion.lua')

-- Passwords
dofile('passwords.lua')

-- MQTT / light commands
dofile('mqtt.lua')

-- Start linear animation
led_animate_bounce()
