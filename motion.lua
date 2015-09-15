gpio.mode(10, gpio.INPUT)

was_moving = 0

function motion_start()
  led_animate_fade(true)
end

function motion_stop()
  led_animate_fade(false, function()
    led_stop()
    led_only(16)
  end)
end

function check_for_motion()
  local moving = gpio.read(10)
  if moving ~= was_moving then
    if moving > 0 then
      motion_start()
    else
      motion_stop()
    end
    was_moving = moving
  end
end

tmr.alarm(2, 100, 1, check_for_motion)
