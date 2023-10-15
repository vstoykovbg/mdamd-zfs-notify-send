This script is using `notify-send` to notify the user about problems with mdadm (software RAID) and ZFS.

It looks for suspicious strings in the output of the command `sbin/zpool status` and looks for the symbol `_` (underscore) in the file `/proc/mdstat`.

The script must be started as the user who will receive the notification.

For example, if the script is located at `/home/user/bin/zfs-health.bash` the file `/var/spool/cron/crontabs/user` contains:

    # zfs health monitor
    * * * * * /home/user/bin/zfs-health.bash

This way the script is started by cron every minute.
