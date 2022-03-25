set -x

# --match-user: we should only kill connections that comes from our application server.
# Be careful not to kill important connection such as things related to replication or aws rds management.

# --wait-before-kill: give our node js logger the chance to retreive connection history before killing it.

export DB_HOST='lom-snapshot-321.cqkuwpenkdlx.ap-east-1.rds.amazonaws.com'
export DB_USER='DbSavior'
export DB_PWD='Qwer!234'
export DB_NAME='Log'
export DB_TZ='Z'

echo ${DB_HOST:?err}
echo ${DB_USER:?err}
echo ${DB_PWD:?err}

pt-kill --host ${DB_HOST:?err} \
--user ${DB_USER:?err} --password ${DB_PWD:?err} \
--match-user 'Worker|WebServer' \
--match-command Sleep --idle-time 60 \
--victims all \
--interval 5 \
--log-dsn 'D=Log,t=KilledProcess' \
--wait-before-kill 10 \
--rds  \
--print --kill | node killLog.js