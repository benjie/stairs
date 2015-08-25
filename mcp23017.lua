mcp23017_address = 0x27
i2c.setup(0, 3, 4, i2c.SLOW)

function write_mcp(...)
  i2c.start(0)
  i2c.address(0,mcp23017_address,i2c.TRANSMITTER)
  for i, v in ipairs(arg) do
    i2c.write(0,v)
  end
  i2c.stop(0)
end

function read_mcp(control)
  i2c.start(0)
  i2c.address(0,mcp23017_address,i2c.RECEIVER)
  i2c.write(0,control)
  i2c.stop()
  i2c.start()
  value = i2c.read(0, 1)
  i2c.stop(0)
  return value
end 

write_mcp(0x12, 0xff) -- make port A high
write_mcp(0x00, 0x00) -- port A -> output
write_mcp(0x13, 0xff) -- make port B high
write_mcp(0x01, 0x00) -- port B -> output
write_mcp(0x0A, 0x20) -- binary 00100000 - seqop=1 (disabled)

function write_both(a, b)
  write_mcp(0x12, a, b)
end

function write_big(v)
  write_both(bit.band(v, 255), bit.band(bit.rshift(v, 8), 255))
end
