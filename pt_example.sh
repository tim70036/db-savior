set -x
# Need credentials to connect to db.
# Note that this db user must have global PROCESS, EXECUTE privileges and some basic rights on information_schema & performance_schema.

echo ${DB_HOST:?err}
echo ${DB_USER:?err}
echo ${DB_PWD:?err}


# Kill sleep connections and log the sql history of that connection.
# Very beatiful, very powerful.
# --match-user: we should only kill connections that comes from our application server.
# Be careful not to kill important connection such as things related to replication or aws rds management.
# --wait-before-kill: give our node js logger the chance to retreive connection history before killing it.
# But don't wait for too long since pt-kill will not move before killing process.
pt-kill --host ${DB_HOST:?err} \
--user ${DB_USER:?err} --password ${DB_PWD:?err} \
--match-user 'Worker|WebServer' \
--match-command Sleep --idle-time 60 \
--victims all \
--interval 5 \
--log-dsn D=${DB_NAME:?err},t=KilledProcess \
--wait-before-kill 5 \
--rds  \
--print --kill | node killedProcessLogger.js

# Log deadlocks.
pt-deadlock-logger --host ${DB_HOST:?err} \
--user ${DB_USER:?err} --password ${DB_PWD:?err} \
--interval 5 \
--dest D=${DB_NAME:?err},t=Deadlock

# Log fk errors.
pt-fk-error-logger h=${DB_HOST:?err},u=${DB_USER:?err},p=${DB_PWD:?err} \
--interval 5 \
--dest D=${DB_NAME:?err},t=ForeignKeyError


pt-archiver \
--source h=${DB_HOST:?err},u=${DB_USER:?err},p=${DB_PWD:?err},A=utf8mb4,D=Joker,t=RankRecord \
--dest h=${DB_HOST:?err},u=${DB_USER:?err},p=${DB_PWD:?err},A=utf8mb4,D=JokerArchive,t=RankRecord \
--where "create_time < DATE('2022-04-13 10:56:20') - INTERVAL 28 DAY" \
--bulk-delete --bulk-insert --commit-each --limit 1000 \
--why-quit \
--statistics \
--progress 1000 \
--no-delete


