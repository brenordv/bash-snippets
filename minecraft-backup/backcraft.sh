#!/bin/bash

###########################################################################################
# Config                                                                ###################
###########################################################################################

# Base config
minecraft_folder="/var/games/minecraft"
servers_folder="servers"
archives_folder="archive"
logs_folder="logs"
world_name="WorldOfOurCraft"
latest_log_folder="$minecraft_folder/$servers_folder/$world_name/$logs_folder"
latest_log="$latest_log_folder/latest.log"
text_to_search="left the game"
backup_filename="server_$world_name$(date +"_%Y%m%d_%H%M%S").tar.gz"
backup_file="$minecraft_folder/$archives_folder/$world_name/$backup_filename"
backup_source_files="$minecraft_folder/$servers_folder/$world_name"
max_backup_days=14

# checks if the last line of the log is a message informing that a player has left...
last_log_line=$(tail  -n 1 $latest_log | grep -a "$text_to_search")

# Checks if TAR package exists...
tar_exists=$(dpkg -l | grep -c "tar archiving")


###########################################################################################
# Functions                                                             ###################
###########################################################################################

# Adds a line to the end of the log file.
# This will also avoid unecessary backups.
add_line_to_log() {
    echo "[$(date +"%T")] [Backup thread/INFO]: $1" >> $latest_log
}

# Removes old backupds.
# You know, just to tidy things up a bit...
# The number of days a backup can leave is defined in the variable max_backup_days
remove_old_backups() {
    find $minecraft_folder/$archives_folder/$world_name* -mtime +$max_backup_days -exec rm {} \;
}


###########################################################################################
# Execution                                                             ###################
###########################################################################################

# Pre backup...
if [[ $tar_exists = 0 ]]; then
    echo "ERROR: Tar package isnt installed! We need that..."
    echo "Try: apt-get install tar"
    exit -1
fi

# Backup routine...
if [[ "$last_log_line" = "" ]]; then
    # Probably somebody has played or is playing...
    echo "Someone is playing. Maybe later..."
else 
    # Assuming the server is empty...
    # Someone has left and nothing else happened. It's safe to make a backup...probably.
    echo "Server empty. Backing stuff up..."
    add_line_to_log "Automatic backup in progress..."

    # Creates the archive
    tar --exclude="./*.log" --exclude="./$logs_folder/*.log" --exclude="./$logs_folder/*.log.gz" -zcvf "$backup_file" "$backup_source_files"

    # Removing old backups
    remove_old_backups

    # Adding another line to the log, to show everythings OK.
    add_line_to_log "Automatic backup finished successfully!"    
    
fi


# OK
exit 0
