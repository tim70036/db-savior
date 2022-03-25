
# --match-user: we should only kill connections that comes from our application server.
# Be careful not to kill important connection such as things related to replication or aws rds management.

# --wait-before-kill: give our node js logger the chance to retreive connection history before killing it.

pt-kill --host ${DB_HOST:?err} \
--user ${DB_USER:?err} --password ${DB_PWD:?err} \
--match-user 'Test.*'
--match-command Sleep --idle-time 30 \
--victims all \
--interval 5 \
--log-dsn 'D=Log,t=KilledProcess' \
--wait-before-kill 10 \
--rds  \
--print --kill | node killLog.js