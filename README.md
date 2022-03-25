# db-savior

## Setup
1. Install percona toolkit and node js (see `install.sh` and READ it).
2. Create schema and tables in database for logging. 
3. Set environment variables for connecting to DB. Make sure your db user has the correct privileges (not too big or small). Usually, it will need global PROCESS, EXECUTE privileges and some basic read permission on information_schema & performance_schema.
4. Run pt command (see `pt_example.sh`). You might want to use `tmux` to manage each pt process.


