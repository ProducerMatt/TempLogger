# redbean-powered temperature logging

## Objective
I want to keep a log of the temperature of a faulty refrigerator.

### Required
- Provide a webpage where user can look at a log of temperatures
- Allow user to add new temperature entries, and new sensors those temps wre
  recorded from.
- Graph temperatures over time, with candles for min/max temperature change

### Would be nice
- User may request log of all temps in CSV or SQL
- Live-streaming graph
- User may specify a data source for redbean to regularly grab and add to
  database automatically, even when no attached browser window
- Some kind of *basic* reliability/security features. Disk space quota? Shutdown
  on anomalous request volume?

## Context
I have no prior experience in web dev, database administration, etc. so this is
all new ground.

Current status of the project: learning the basic technologies and how to
connect them. Mostly frankedsteined from examples. So far I can read rows from
the database to the browser, and add more.

## How to use
Run `./build.sh` to pack a redbean instance with the contents of `./srv/`. Once
you launch the redbean be sure to initialize a DB with `TempDbInit()`. Launch it
to play around with what's there (it's going to change a lot at this point).
Expect ugliness. :-)
