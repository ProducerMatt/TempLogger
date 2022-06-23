Query = FridgeDump()
SetHeader('Content-Type', 'text/plain; charset=utf-8')
for row in Query do
  Write(table.unpack(row))
end
