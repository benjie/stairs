boot = true

function start()
  if boot then
    dofile("main.lua")
  else
    print("Aborted boot before main")
  end
end

function remote()
  if boot then
    -- Connect to wifi
    dofile('wifi.lua')

    -- Set up telnet server
    dofile('telnet.lua')
    tmr.alarm(0, 15000, 0, start)
  else
    print("Aborted boot before remote setup")
  end
end

tmr.alarm(0, 5000, 0, remote)
