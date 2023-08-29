log_file="/var/log/xyz-app.log"
backup_dir="/var/log/backup"
max_backups=5
timestamp=$(date + '%Y%m%d' )

mkdir -p ${backup_dir}

backup_file="${backup_dir}/xyz-app-${timestamp}.log"

if [ -f "${log_file}" ] && [ -s "${log_file}" ]; then
  cp "${log_file}" "${backup_file}"
  > "${log_file}"

  backup_files=("$backup_dir"/xyz-app*.log)

  if [ ${#backup_files[@} -gt $max_backups ]; then
    num_to_remove=$(( ${#backup_files[@]} - max_backups ))

    for file in $( ls -lt "$backup_dir"/xyz-app*.log | tail -n $num_to_remove ); do
      rm -f $file
    done
  fi
else
  echo log file doesnt exist or it is empty
fi



