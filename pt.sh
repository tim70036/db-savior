
# DB separate schema for killing? DBA schema

pt-kill --host ${DB_HOST:?err} \
--user ${DB_USER:?err} --password ${DB_PWD:?err} \
--match-command Sleep --match-user 'Test.*' --idle-time 30 \
--victims all \
--interval 5 \
--create-log-table --log-dsn 'D=Joker,t=percona_kill_log' \
--wait-before-kill 20 \
--rds  \
--print | node killLog.js