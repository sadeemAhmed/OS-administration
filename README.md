# OS-administration-
We have written several codes for system backups, and others for converting some data into a copyable and sendable file. This is to demonstrate our skills in dealing with operating systems, especially Linux.

we define description fo each code:
IN Q1:
we created a script, named "Qs1.sh",
1. `#!/bin/bash`:
   - This line is called a "shebang" and it specifies that the script should be executed using the Bash shell.

2. `backupDir="/home/sadeem/backup"`:
   - This line defines a variable named `backupDir` and assigns it the value `/home/sadeem/backup`. This is the directory where backups will be stored.

3. `backupFile="system_backup_$(date +%d%m%y).tar.gz"`:
   - This line defines a variable named `backupFile` and assigns it a value generated using the `date` command. This value will be in the format `system_backup_ddmmyy.tar.gz`, where `%d%m%y` represents the day, month, and year.

4. `encryptedBackupFile="$backupDir/system_backup_$(date +%d%m%y).tar.gz.gpg"`:
   - This line defines a variable named `encryptedBackupFile` and assigns it a value similar to `backupFile`, but with a `.gpg` extension. This will be the name of the encrypted backup file.

5. `email="sadeem1212@hotmail.com"`:
   - This line defines a variable named `email` and assigns it the value `sadeem1212@hotmail.com`. This is the email address where the backup will be sent.

6. `if [ ! -d "$backupDir" ]; then mkdir -p "$backupDir"; fi`:
   - This is an `if` statement that checks whether the directory specified by `backupDir` exists. If it doesn't (`! -d` checks if it's not a directory), it creates it using `mkdir -p`.

7. `sudo tar -czvf "$backupDir/$backupFile" --exclude=/proc --exclude=/sys --exclude=/dev --exclude=/run --exclude=/mnt --exclude=/media --exclude=/lost+found --one-file-system /`:
   - This command creates a compressed archive using `tar`. Here's a breakdown of the options and arguments:
     - `-czvf`: This is a combination of options. `c` stands for create a new archive, `z` compresses the archive using gzip, `v` enables verbose mode (prints progress), and `f` specifies the archive file to create.
     - `"$backupDir/$backupFile"`: This is the path and name of the archive file that will be created.
     - `--exclude=/proc --exclude=/sys --exclude=/dev --exclude=/run --exclude=/mnt --exclude=/media --exclude=/lost+found --one-file-system`: These are the directories excluded from the backup, as they typically contain data not needed for a system backup. They are specified with the `--exclude` option.

8. `echo "Your Passphrase" | gpg --batch --symmetric --output "$encryptedBackupFile" --passphrase-fd 0 "$backupDir/$backupFile"`:
   - This command encrypts the backup file using `gpg`. Here's a breakdown:
     - `echo "Your Passphrase"`: This provides the passphrase to `gpg`. You should replace `"Your Passphrase"` with your actual passphrase.
     - `|`: This is a pipe, which passes the output of the preceding command to the input of the following command.
     - `gpg --batch --symmetric --output "$encryptedBackupFile" --passphrase-fd 0 "$backupDir/$backupFile"`: This command encrypts the file. Here's what the options do:
       - `--batch`: Runs GnuPG in batch mode, which is useful for scripting.
       - `--symmetric`: This uses symmetric (passphrase-based) encryption.
       - `--output "$encryptedBackupFile"`: Specifies the output file for the encrypted backup.
       - `--passphrase-fd 0`: Indicates that the passphrase will be read from file descriptor .
       - `"$backupDir/$backupFile"`: Specifies the file to be encrypted.

9. The next part of the script determines how the email will be sent. It checks if the `mutt` command is available, and if so, it uses `mutt` to send the email with the encrypted backup file as an attachment. If `mutt` is not available, it uses `sendmail` to send the email.

   - `if command -v mutt &> /dev/null; then ... else ... fi`:
     - This checks if the `mutt` command is available.

   - `echo "Weekly system backup file" | mutt -s "Weekly System Backup" -a "$encryptedBackupFile" -- "$email"`:
     - If `mutt` is available, this sends an email with the subject of "Weekly System Backup", the message body being "Weekly system backup file", and the encrypted backup file attached.

   - If `mutt` is not available, it falls back to using `sendmail`:
     - `echo "Subject: Weekly System Backup" | cat - "$encryptedBackupFile" | /usr/sbin/sendmail -t "$email"`:
       - This composes an email with the subject of "Weekly System Backup", concatenates it with the encrypted backup file, and then uses `sendmail` to send the email.

Overall, My script named "Qs1.sh", serves as an automated backup solution for a Linux system. It performs a weekly backup of essential system files and directories, excluding unnecessary ones. The backup is compressed and saved in a designated directory. Following this, the script encrypts the backup file using GPG for added security. Once encrypted, the file is sent to my specified email address for safekeeping. Lastly, I've set up the script to run weekly using the cron job scheduler, ensuring regular, automated backups without manual intervention. This script offers a streamlined and secure approach to safeguarding critical system data.


IN Q2:
-  #! /bin/bash
This line is called a shebang (#!). It's used to tell the system that this script should be executed using bash, the Bourne Again SHell.
-read -p "Enter username :" username
The read is a built-in command in the bash shell. It reads a line of input from standard input (the keyboard, in this case). The -p option specifies a prompt to display before the input line. Here, it's asking for a username and storing the input in a variable named username.
-grep "$username" /var/log/auth.log > ~/ActivitiesLog.txt
grep is a command-line utility for searching plain-text data for lines that match a regular expression. Here, it's used to search for the value of username in the /var/log/auth.log file. The /var/log/auth.log file is a system log file that contains authentication information.

The > symbol is used here to redirect output. Instead of printing the grep results to the console, it writes them to a file. In this case, the output is being redirected to ~/ActivitiesLog.txt, where ~ is a shorthand way of referring to the current user's home directory.

So the script does the following:
It prompts the user to enter a username.
It then searches the /var/log/auth.log file for lines containing that username.
It writes the results of that search to a file named ActivitiesLog.txt in the current user's home directory.

IN Q3 :
The script is a Bash script designed to interact with the user and retrieve information about processes. It prompts the user to enter a username and then lists the top 5 processes owned by that user based on memory usage.
1. `#!/bin/bash`: it specifies the interpreter that should be used to execute the script. In this case, it indicates that the script should be interpreted using the Bash shell.
2. `echo "enter the user name :"`: This line displays the message "enter the user name :" on the console. It prompts the user to enter a username.
3. `read username`: The `read` command reads the input provided by the user and assigns it to the variable `username`. The user's input is stored in the `username` variable for later use.
4. `ps -u"$username" -o pid,ppid,cmd,%mem --sort=-%mem | head -n 6`: This line executes the `ps` command to list the top 5 processes for the specified `username`. Here's a breakdown of the options used:
`-u "$username"`: Specifies the username for which processes should be listed.
`-o pid,ppid,cmd,%mem`: Specifies the format of the output. In this case, it includes the process ID, parent process ID, command, and memory usage percentage.
`--sort=-%mem`: Sorts the processes based on memory usage in descending order.
`| head -n 6`: Pipes the output of the `ps` command to the `head` command, which selects the first 6 lines. This includes the header and the top 5 processes.
In summary, the script prompts the user to enter a username. It then uses the `ps` command to retrieve information about the processes owned by that user and displays the top 5 processes based on memory usage.

IN Q4:
1. The script checks if the number of command-line arguments is not equal to 1. If there is not exactly one argument provided, it prints an error message and exits the script.
2. The script assigns the value of the first command-line argument (the port number) to the variable `port`.
3. The script uses the `nc` (netcat) command to check the status of the specified port on the local machine (`localhost`).
4. If the port is open, the script prints a message indicating that the port is open.
5. If the port is closed, the script prints a message indicating that the port is closed.

Overall, the script is going to check the status of a specified port and print a message whether the port is open or not, or print an error message when there is no argument provided.
