gpio.mode(10, gpio.INPUT)

was_moving = 0

function check_for_motion()
  local moving = gpio.read(10)
  if moving ~= was_moving then
    if moving > 0 then
      led_dim_all(5)
    else
      led_animate_bounce()
    end
    was_moving = moving
  end
end

tmr.alarm(2, 500, 1, check_for_motion)
