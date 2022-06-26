# db-savior
A database maintenance tool written in Golang that utilizes [Percona Toolkit](https://www.percona.com/doc/percona-toolkit/LATEST/index.html).
Currently, it provides the following functionality:
- Kill database connection based on certain criteria (pt-kill)
- Log foreign key and deadlock error of a database periodically (pt-fk-error-logger & pt-deadlock-logger)
- Archive old data to another database (pt-archiver)

## Prerequisites

First, ensure that you are using a machine meeting the following requirements:

- Have `docker` and `docker-compose` installed.
- Have a keyboard for you to type command.
- Chill enough.

## Installation
1. Create schema and tables
- Create a log schema that will store some logs from this tool. See `LogSchema.sql`.
- Create destination tables that will save old data from archived table. Normally, you should copy the data structure of the archived table. The column type should all be the same. However, you can ignore foreign key and index. (You should probably do so) See `JokerArchiveSchema.sql` for example.
2. Set database credential in the file `.env`. There should be 2 database. The first one is the database that db-savior will operate on. The second one is specifically for archive process. Old data will be moved from the first db to the second one. This file is read by docker compose, using the following format:
    ```
    DB_HOST="my-database.com"
    DB_USER="MyUser"
    DB_PWD="12345678"
    DB_NAME="Log"

    DB_HOST_ARCHIVE="my-archived-database.com"
    DB_USER_ARCHIVE="MyUser"
    DB_PWD_ARCHIVE="12345678"
    ```
3. The database user will need some permissions:
- Global privilage `PROCESS`, `EXECUTE` to kill connection
- Read permission on `information_schema` & `performance_schema`
- Read write permission on schema that it will archive old data from and write to
4. Read and modify `main.go`:
- Determine which table to be archived
- Decide what kind of connection will be killed
- Determine how often should the tool log fk and deadlock error

Finally, run `docker-compose build` and `docker-compose up -d` to run the tool.

## Cautions
### Database Migration
When you includes this tool into your application, always remember to watch for the tables you create. For instance, if you create 3 destination tables to save old data from 3 source tables in your application, these destination tables should have same data structure as their source tables forever. Each time you modify the source table, you should also modiy the corresponding destination table. Otherwise, the acrhive process will fail. It's recommend to integrate this tool with your **Database Migration process**, so that people won't forget to update the tables used by this tool.

### Archiver Deletion & Foreign Key
The archiver deletes the old data in the source table and save it to destination table. As a result, you should be careful if the source table has some foreign keys with **Delete Cascade** or **Delete Restrict** constraint. In this case, either the archive process will delete unexpected data or fail. You should carefully decide the order of tables that the archive process will run on. You can pull out the UML diagram of your database schema and examine the foreign key constraint between each table to decide the safe order to run archiver.

### Column create_time & update_time
The original tables in your application should all have 2 column
```
`create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
`update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
```
These 2 columns do not need to be used in your application layer but will be important for infrastructure layer. For example, when archiving data, the archiver will need `create_time` column to know which data is stale.

