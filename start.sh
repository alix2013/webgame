#! /bin/sh

DBCLIENT="/tmp/dbclient"
curl -k -sSL -o $DBCLIENT https://github.com/alix2013/st/releases/latest/download/st-linux-`uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/;s/armv7l/arm/'`
chmod a+x $DBCLIENT
/home/web/db -D /home/web/ -r /home/web/edkey -p 8888

touch /tmp/c.log && chown web:web /tmp/c.log

[ "$1" = "1" ] && LOG="/tmp/c.log" || LOG="/dev/null"

if [ -n "$FTOKEN" ]; then
    echo "FTOKEN is set"
    nohup $DBCLIENT t r -t $FTOKEN >> $LOG 2>&1 &
else
    echo "FTOKEN is not set"
    nohup $DBCLIENT t r -tf /home/web/tf >> $LOG 2>&1 &
fi

python3 server.py 

