#
./servicemix/bin/servicemix server & 

list=$(echo "$features" | sed -e 's/,/\n/g')
echo "features to be installed:"$list
sshpass -p smx ssh -p 8101 -o StrictHostKeyChecking=no smx@localhost "features:install $(echo $list) ; osgi:shutdown --force"
while [ "$?" != "0" ]; do
	sleep 5s
	sshpass -p smx ssh -p 8101 -o StrictHostKeyChecking=no smx@localhost "features:install $(echo $list) ; osgi:shutdown --force"
done

echo "done"
exit 0
