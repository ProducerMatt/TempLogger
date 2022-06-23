local TempMod = {}

function SetupSQL()
  if not db then
    db = sqlite3.open('tempbean.sqlite3')
    db:busy_timeout(1000)
    db:exec[[PRAGMA journal_mode=WAL]]
    db:exec[[PRAGMA synchronous=NORMAL]]
  end
end
function TempPrepDump()
  return db:prepare[[
         SELECT
            *
         FROM
            temps;
      ]]
end
function TempDump()
  if not db then
    SetupSQL()
  end
  getTempStmt = TempPrepDump()
  if not getTempStmt then
    Log(kLogWarn, 'prepare failed: ' .. db:errmsg())
    return nil
  end
  getTempStmt:reset()
  -- getTempStmt:bind(1, id)
  return getTempStmt--:rows()
end
function TempDbInit()
  if not db then
    SetupSQL()
  end
  db:exec[[
    CREATE TABLE temps (
        id INTEGER PRIMARY KEY,
        content TEXT
    );
    INSERT INTO temps (content) VALUES ('Hello World');
    INSERT INTO temps (content) VALUES ('Hello Lua');
    INSERT INTO temps (content) VALUES ('Hello Sqlite3');
    ]]
end

return TempMod
