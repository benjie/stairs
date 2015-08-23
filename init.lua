boot = true
function start()
  if boot then
    dofile("main.lua")
  end
end

tmr.alarm(0, 30000, 0, start)
