mqtt_client = mqtt.Client(mqtt_client_id, 15, mqtt_username, mqtt_password)

mqtt_commands = {}

mqtt_commands["stairs/lights/cmd:fadein"] = function(conn, topic, data)
  led_animate_fade(true)
end

mqtt_commands["stairs/lights/cmd:fadeout"] = function(conn, topic, data)
  led_animate_fade(false, function()
    led_stop()
    led_only(16)
  end)
end

mqtt_commands["stairs/lights/cmd:bounce"] = function(conn, topic, data)
  led_animate_bounce()
end

mqtt_commands["stairs/lights/cmd:lineardown"] = function(conn, topic, data)
  led_animate_linear(1)
end

mqtt_commands["stairs/lights/cmd:linearup"] = function(conn, topic, data)
  led_animate_linear(-1)
end

mqtt_client:on("connect", function(conn, topic, data)
  for cmd in pairs(mqtt_commands) do
    mqtt_client:subscribe(cmd, 0)
  end
  mqtt_client:publish("landing/motion/online", "", 0, 0)
end)

mqtt_client:on("message", function(conn, topic, data)
  if mqtt_commands[topic] then
    mqtt_commands[topic]()
  end
end)

mqtt_client:on("offline", function(conn, topic, data)
  mqtt_client:connect("192.168.0.24", 1883, 0)
end)


function motion_start()
  mqtt_client:publish("landing/motion/start", "", 0, 0)
end

function motion_stop()
  mqtt_client:publish("landing/motion/stop", "", 0, 0)
end

mqtt_client:connect("192.168.0.24", 1883, 0)
