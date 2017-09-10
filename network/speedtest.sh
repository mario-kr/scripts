#!/usr/bin/env bash

#previously measured with du
filesize=1092

# timestamp for elasticsearch, only sec precision
timestamp="$(date +%s)000"

# time in nanosec before start
timepre=$(date +%s%N)

# download 1092 Byte file
curl -o /dev/null http://mirror.nforce.com/pub/speedtests/mini/speedtest/random750x750.jpg 2>&1 1>/dev/null
stat=$?

# time after download in nanosec
timepost=$(date +%s%N)

# diff in nanosec.
timediff=$(bc <<<"$timepost - $timepre")

# download failed? -> 0 Bytes downloaded
if [ $stat -ne 0 ]; then
    filesize=0
fi

# actual download rate, probably inaccurate,
# but it should be consistently inaccurate.
# I dont care about +/- 10 KB/s
# times 1 billion because of nanosec pecision
# rounded/snipped to whole bytes/s
dl_rate=$(bc <<<"( $filesize *1000000000 ) / $timediff")

# put it in the elasticstack
curl -XPUT "http://localhost:9200/dlrate/cron/$timestamp" -H 'Content-Type: application/json' --data @<(cat <<EOF
{
    "@timestamp" : ${timestamp},
    "timediff" : ${timediff},
    "filesize" : ${filesize},
    "download_rate" : ${dl_rate}
}
EOF
)

