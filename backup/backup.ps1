

# set the database name and backup directory
$DATABASE_NAME="postgres"
$BACKUP_DIR="C:/Users/Tomas/IdeaProjects/Bds_projekt_3/backup"

# create a filename with the current date
$FILENAME="backup-$(Get-Date -UFormat "%Y-%m-%d").sql"

# use pg_dump to create a backup of the database
pg_dump --format=custom --dbname=postgresql://postgres:admin123@localhost:5432/$DATABASE_NAME -f "$BACKUP_DIR/$FILENAME" 





