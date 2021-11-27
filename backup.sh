#!/bin/zsh

PID_FILE=~/.restic_backup.pid
TIMESTAMP_FILE=~/.restic_backup_timestamp

if [ -f "$PID_FILE" ]; then
  if ps -p $(cat $PID_FILE) > /dev/null; then
    echo $(date +"%Y-%m-%d %T") "File $PID_FILE exist. Probably backup is already in progress."
    exit 1
  else
    echo $(date +"%Y-%m-%d %T") "File $PID_FILE exist but process " $(cat $PID_FILE) " not found. Removing PID file."
    rm $PID_FILE
  fi
fi

if [ -f "$TIMESTAMP_FILE" ]; then
  time_run=$(cat "$TIMESTAMP_FILE")
  current_time=$(date +"%s")

  if [ "$current_time" -lt "$time_run" ]; then
    exit 2
  fi
fi

if [[ $(pmset -g ps | head -1) =~ "Battery" ]]; then
  echo $(date +"%Y-%m-%d %T") "Computer is not connected to the power source."
  exit 4
fi

echo $$ > $PID_FILE
echo $(date +"%Y-%m-%d %T") "Backup start"

export AWS_ACCESS_KEY_ID=$(security find-generic-password -s backup-restic-aws-access-key-id -w)
export AWS_SECRET_ACCESS_KEY=$(security find-generic-password -s backup-restic-aws-secret-access-key -w)
export RESTIC_REPOSITORY=$(security find-generic-password -s backup-restic-repository -w)
export RESTIC_PASSWORD_COMMAND='security find-generic-password -s backup-restic-password-repository -w'

/usr/local/bin/restic backup --verbose --files-from ~/backup.txt 

echo $(date +"%Y-%m-%d %T") "Backup finished"
echo $(date -v +6H +"%s") > $TIMESTAMP_FILE

rm $PID_FILE
