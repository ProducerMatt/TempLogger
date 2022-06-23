local FridgeMod = {}

function SetupSQL()
  if not db then
    db = sqlite3.open('fridgebean.sqlite3')
    db:busy_timeout(1000)
    db:exec[[PRAGMA journal_mode=WAL]]
    db:exec[[PRAGMA synchronous=NORMAL]]
  end
end
function FridgePrepDump()
  return db:prepare[[
         SELECT
            *
         FROM
            fridge;
      ]]
end
function FridgeDump()
  if not db then
    SetupSQL()
  end
  getFridgeStmt = FridgePrepDump()
  if not getFridgeStmt then
    Log(kLogWarn, 'prepare failed: ' .. db:errmsg())
    return nil
  end
  getFridgeStmt:reset()
  -- getFridgeStmt:bind(1, id)
  return getFridgeStmt--:rows()
end
function FridgeDbInit()
  if not db then
    SetupSQL()
  end
  db:exec[[
    CREATE TABLE fridge (
        id INTEGER PRIMARY KEY,
        content TEXT
    );
    INSERT INTO fridge (content) VALUES ('Hello World');
    INSERT INTO fridge (content) VALUES ('Hello Lua');
    INSERT INTO fridge (content) VALUES ('Hello Sqlite3');
    ]]
end

return FridgeMod
