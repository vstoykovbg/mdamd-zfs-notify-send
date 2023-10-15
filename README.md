This script is using `notify-send` to notify the user about problems with mdadm (software RAID) and ZFS.

It looks for suspicious strings in the output of the command `sbin/zpool status` and looks for the symbol `_` (underscore) in the file `/proc/mdstat`.

The script must be started as the user who will receive the notification.

For example, if the script is located at `/home/user/bin/zfs-health.bash` the file `/var/spool/cron/crontabs/user` contains:

    # zfs health monitor
    * * * * * /home/user/bin/zfs-health.bash

This way the script is started by cron every minute.

# How to test it to see if `notify-send` works

Don't forget to `chmod +x /home/user/bin/zfs-health.bash` and test if it works by editing the script (after making a backup!) like this:

     condition=$(/sbin/zpool status | egrep '(ONLINE|DEGRADED|FAULTED|OFFLINE|UNAVAIL|REMOVED|FAIL|DESTROYED|corrupt|cannot|unrecover)')

(I inserted "ONLINE|" before "DEGRADED".)

After about 1 minute or less you shold receve a notification. If you don't - something is not right. Check your cron configuration.

If you don't have ZFS (you use the script to monitor your software RAID) edit it like this:

    if grep "U" /proc/mdstat ; then

(I replaced the underscore (`_`) symbol with `U`.)
