Query = TempDump()
SetHeader('Content-Type', 'text/plain; charset=utf-8')
for row in Query:nrows() do
  Write(tostring(row.content)..'\n')
end
Query:finalize()
