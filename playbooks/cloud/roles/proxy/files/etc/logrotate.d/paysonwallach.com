/home/paysonwallach/nginx/log/paysonwallach.com.access.log {
    weekly
    rotate 52
    missingok
    notifempty
    sharedscripts
    compress
    prerotate
        /usr/bin/python3 /home/paysonwallach/sites/analytics.paysonwallach.com/misc/log-analytics/import_logs.py --url=https://analytics.paysonwallach.com --login paysonwallach --password uncaring-authentic-SLICER-SIMPLY --idsite=1 --recorders=4 /home/paysonwallach/nginx/log/paysonwallach.com.access.log
    endscript
    postrotate
        /usr/bin/docker exec sites /bin/sh -c '/usr/bin/nginx -s reopen > /dev/null 2>/dev/null'
    endscript
}
