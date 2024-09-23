Bullschit aber Funktioniert

ISCSI auf ESXI wird nur beim booten gescant, wenn das LUN ueber eine VM auf dem gleichen Host bereitgestellt wird, 
muss dieser scan nach dem Booten neu gestartet werden.

Befehl:
esxcli storage core adapter rescan --all

Automatisierung ueber cron Job:
vi /etc/rc.local.d/local.sh #Oder mit WinSCP
#Folgende Zeilen einfuegen
/bin/kill $(cat /var/run/crond.pid)
/bin/echo "*/5    *    *   *   *   esxcli storage core adapter rescan --all" >> /var/spool/cron/crontabs/root
/usr/lib/vmware/busybox/bin/busybox crond