sqlite3 = require "lsqlite3"
FridgeMod = require "FridgeMod"

HidePath('/usr/share/zoneinfo/')
HidePath('/usr/share/ssl/')

function foo()
  print("success!")
end

function bar()
  foo()
end
