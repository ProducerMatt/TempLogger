local TempMod = {}

database_path = 'tempbean.sqlite3'

function SetupSQL()
  if not db then
    db = sqlite3.open(database_path)
    db:busy_timeout(1000)
    db:exec[[PRAGMA journal_mode=WAL]]
    db:exec[[PRAGMA synchronous=NORMAL]]
  end
end

function TempPrepDump()
  if not db then
    SetupSQL()
  end
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
  return getTempStmt
end

function TempPrepAppend()
  if not db then
    SetupSQL()
  end
  return db:prepare[[
        INSERT INTO temps (content) VALUES ( ? );
      ]]
end
function TempAppend(stuff)
  if not db then
    SetupSQL()
  end
  local getTempStmt = TempPrepAppend()
  if not getTempStmt then
    Log(kLogWarn, 'TempAppend prepare failed: ' .. db:errmsg())
    return nil
  end
  getTempStmt:reset()
  getTempStmt:bind(1, stuff)
  status = getTempStmt:step()
  getTempStmt:finalize()
  return status
end

function TempDbInit()
  if not db then
    SetupSQL()
  end
  db:exec[[
    BEGIN TRANSACTION;
    CREATE TABLE temps (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT
    );
    INSERT INTO temps (content) VALUES ('Hello World');
    INSERT INTO temps (content) VALUES ('Hello Lua');
    INSERT INTO temps (content) VALUES ('Hello Sqlite3');
    COMMIT TRANSACTION;
    ]]
end

return TempMod
