#! bin bash
 echo enter the user name :
read username
 ps -u"Susername" -o pid, ppid, cmd, %mem --sort=-%mem | head -n 6
