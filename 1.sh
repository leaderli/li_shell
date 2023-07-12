source ./li_daemon.sh

daemon_pid daemon.pid

echo $?
echo 123123
i=0
while [ 1 ]
do
(( i++ ))
echo $i
sleep 1
done
