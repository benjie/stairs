function led_only(l)
  write_big(bit.bxor(0xFFFF, bit.lshift(1, l - 1)))
end

_led_animation_delay = 62

function led_stop()
  tmr.stop(0)

  -- Reset variables
  _led_nr = 0
  _led_direction = 1
  _led_bounce = false
end

------------------------------------------
-- Linear animation
------------------------------------------

function _led_animate_linear()
  led_only(_led_nr)
  _led_nr = _led_nr + _led_direction
  -- Blah
  if _led_nr > 16 then
    -- Blah 2
    if _led_bounce then
      _led_direction = -1
      _led_nr = 15
    else
      _led_nr = 1
    end
  elseif _led_nr < 1 then
    if _led_bounce then
      _led_direction = 1
      _led_nr = 2
    else
      _led_nr = 16
    end
  end
  led_only(_led_nr)
end

function led_animate_linear(direction)
  led_stop()
  _led_direction = direction
  tmr.alarm(0, _led_animation_delay, 1, _led_animate_linear)
end

------------------------------------------
-- Bounce animation
------------------------------------------

function led_animate_bounce()
  led_stop()
  _led_bounce = true
  tmr.alarm(0, _led_animation_delay, 1, _led_animate_linear)
end
