echo off
echo 'Generating backup'

set DATE_STR=%date%
set DATE=%DATE_STR:/=-%

# set the database name and backup directory
set DATABASE_NAME=postgres
set BACKUP_DIR=C:/Users/Tomas/IdeaProjects/Bds_projekt_3/backup

# create a filename with the current date
set FILENAME=backup-%DATE%.sql

# use pg_dump to create a backup of the database
pg_dump --format=custom --dbname=postgresql://postgres:admin123@localhost:5432/%DATABASE_NAME% -f "%BACKUP_DIR%/%FILENAME%" 

echo 'Generated backup %BACKUP_DIR%/%FILENAME%'



