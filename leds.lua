function led_only(l)
  write_big(bit.bxor(0xFFFF, bit.lshift(1, l - 1)))
end

function all_off()
  write_big(0xFFFF)
end


function led_stop()
  all_off()
  tmr.stop(0)
  tmr.stop(1)

  -- Reset variables
  _led_nr = 0
  _led_direction = 1
  _led_bounce = false
  _led_max_interval = 30
  _led_pulse_delay = 50
  _led_oneway = false
  _led_oneway_cb = nil
  _led_animation_delay = 62
end

------------------------------------------
-- Linear animation
------------------------------------------

function _led_animate_linear()
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

function led_animate_bounce(delay)
  led_stop()
  _led_bounce = true
  _led_animation_delay = delay or _led_animation_delay
  tmr.alarm(0, _led_animation_delay, 1, _led_animate_linear)
end

------------------------------------------
-- Pulse animation
------------------------------------------

function led_flash_all()
  write_mcp(0x12, 0, 0xff, 0xff, 0, 0xff, 0xff)
  tmr.alarm(0, _led_animation_delay, 0, led_flash_all)
end

function _led_animate_pulse()
  _led_animation_delay = _led_animation_delay + _led_direction
  if _led_animation_delay < 1 then
    _led_animation_delay = 2
    _led_direction = 1
  elseif _led_animation_delay > _led_max_interval then
    _led_animation_delay = _led_max_interval - 1
    _led_direction = -1
  end
  tmr.alarm(1, _led_pulse_delay, 0, _led_animate_pulse)
end

function led_animate_pulse(pulse_delay)
  led_stop()
  _led_pulse_delay = pulse_delay or _led_pulse_delay
  tmr.alarm(0, 1, 0, led_flash_all)
  tmr.alarm(1, _led_pulse_delay, 0, _led_animate_pulse)
end

------------------------------------------
-- Dim level
------------------------------------------

function led_dim_all(delay)
  led_stop()
  delay = delay or 1
  if delay < 1 then
    delay = 1
  end
  _led_animation_delay = delay
  led_flash_all()
end
