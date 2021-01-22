echo
echo "*** Adobe Genuine Services Disabler by /u/sjain_guides ***"
echo "Please enter your password below:"
echo

sudo chmod 777 "/Library/Application Support/Adobe/AdobeGCClient"

echo
echo "------------------------------------------------------------"

echo
echo "*** Killing Services ***"
echo

if pgrep -xq -- "AdobeGCClient"; then
    sudo killall -9 "AdobeGCClient"
    echo "AdobeGCClient killed"
else
    echo "AdobeGCClient not running"
fi

if pgrep -xq -- "agcinvokerutility"; then
    sudo killall -9 "agcinvokerutility"
    echo "agcinvokerutility killed"
else
    echo "agcinvokerutility not running"
fi

if pgrep -xq -- "AGMService"; then
    sudo killall -9 "AGMService"
    echo "AGMService killed"
else
    echo "AGMService not running"
fi

if pgrep -xq -- "agshelper"; then
    sudo killall -9 "agshelper"
    echo "agshelper killed"
else
    echo "agshelper not running"
fi

if pgrep -xq -- "AGSService"; then
    sudo killall -9 "AGSService"
    echo "AGSService killed"
else
    echo "AGSService not running"
fi

if pgrep -xq -- "gccustomhook"; then
    sudo killall -9 "gccustomhook"
    echo "gccustomhook killed"
else
    echo "gccustomhook not running"
fi

echo
echo "*** Changing Folder Permissions ***"
echo

sudo chmod 777 "/Library/Application Support/Adobe/AdobeGCClient"
sudo chmod 777 "/Applications/Utilities/Adobe Application Manager/AdobeGCClient"
sudo chmod 777 "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/customhook"
sudo chown $USER "/Library/Application Support/Adobe/AdobeGCClient"
sudo chown $USER "/Applications/Utilities/Adobe Application Manager/AdobeGCClient"
sudo chown $USER "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/customhook"

echo
echo "*** Changing Permissions on, Disabling and Locking Services ***"
echo

if [ -e "/Library/Application Support/Adobe/AdobeGCClient/AdobeGCClient.app" ]; then
	sudo chmod 777 "/Library/Application Support/Adobe/AdobeGCClient/AdobeGCClient.app"
	sudo chmod 777 "/Library/Application Support/Adobe/AdobeGCClient/AdobeGCClient.app/Contents/MacOS/AdobeGCClient"
	sudo chown $USER "/Library/Application Support/Adobe/AdobeGCClient/AdobeGCClient.app"
	sudo chown $USER "/Library/Application Support/Adobe/AdobeGCClient/AdobeGCClient.app/Contents/MacOS/AdobeGCClient"
	> "/Library/Application Support/Adobe/AdobeGCClient/AdobeGCClient.app/Contents/MacOS/AdobeGCClient"
	rm "/Library/Application Support/Adobe/AdobeGCClient/AdobeGCClient.app/Contents/MacOS/AdobeGCClient"
	sudo chmod -w "/Library/Application Support/Adobe/AdobeGCClient/AdobeGCClient.app"
else
	echo "/Library/Application Support/Adobe/AdobeGCClient/AdobeGCClient.app not found - restart your Mac"
fi

if [ -e "/Library/Application Support/Adobe/AdobeGCClient/agcinvokerutility" ]; then
	sudo chmod 777 "/Library/Application Support/Adobe/AdobeGCClient/agcinvokerutility"
	sudo chown $USER "/Library/Application Support/Adobe/AdobeGCClient/agcinvokerutility"
	> "/Library/Application Support/Adobe/AdobeGCClient/agcinvokerutility"
	sudo chmod -w "/Library/Application Support/Adobe/AdobeGCClient/agcinvokerutility"
else
	echo "/Library/Application Support/Adobe/AdobeGCClient/agcinvokerutility not found"
fi
	
if [ -e "/Library/Application Support/Adobe/AdobeGCClient/AGMService" ]; then
	sudo chmod 777 "/Library/Application Support/Adobe/AdobeGCClient/AGMService"
	sudo chown $USER "/Library/Application Support/Adobe/AdobeGCClient/AGMService"
	> "/Library/Application Support/Adobe/AdobeGCClient/AGMService"
	sudo chmod -w "/Library/Application Support/Adobe/AdobeGCClient/AGMService"
else
	echo "/Library/Application Support/Adobe/AdobeGCClient/AGMService not found"
fi

if [ -e "/Library/Application Support/Adobe/AdobeGCClient/agshelper" ]; then
	sudo chmod 777 "/Library/Application Support/Adobe/AdobeGCClient/agshelper"
	sudo chown $USER "/Library/Application Support/Adobe/AdobeGCClient/agshelper"
	> "/Library/Application Support/Adobe/AdobeGCClient/agshelper"
	sudo chmod -w "/Library/Application Support/Adobe/AdobeGCClient/agshelper"
else
	echo "/Library/Application Support/Adobe/AdobeGCClient/agshelper not found"
fi

if [ -e "/Library/Application Support/Adobe/AdobeGCClient/AGSService" ]; then
	sudo chmod 777 "/Library/Application Support/Adobe/AdobeGCClient/AGSService"
	sudo chown $USER "/Library/Application Support/Adobe/AdobeGCClient/AGSService"
	> "/Library/Application Support/Adobe/AdobeGCClient/AGSService"
	sudo chmod -w "/Library/Application Support/Adobe/AdobeGCClient/AGSService"
else
	echo "/Library/Application Support/Adobe/AdobeGCClient/AGSService not found"
fi

if [ -e "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/customhook/gccustomhook" ]; then
	sudo chmod 777 "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/customhook/gccustomhook"
	sudo chown $USER "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/customhook/gccustomhook"
	> "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/customhook/gccustomhook"
	sudo chmod -w "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/customhook/gccustomhook"
else
	echo "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/customhook/gccustomhook not found"
fi

if [ -e "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/AGSService" ]; then
	sudo chmod 777 "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/AGSService"
	sudo chown $USER "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/AGSService"
	> "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/AGSService"
	sudo chmod -w "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/AGSService"
else
	echo "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/AGSService not found"
fi

echo
echo "*** Locking Folders ***"
echo

sudo chmod -w "/Library/Application Support/Adobe/AdobeGCClient"
sudo chmod -w "/Applications/Utilities/Adobe Application Manager/AdobeGCClient"
sudo chmod -w "/Applications/Utilities/Adobe Application Manager/AdobeGCClient/customhook"

echo
echo "*** Completed ***"
echo
echo "------------------------------------------------------------"
echo
