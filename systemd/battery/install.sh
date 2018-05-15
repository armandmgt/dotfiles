#!/bin/bash

GITURL="https://raw.githubusercontent.com/armandmgt/dotfiles/master/systemd/battery/"
SCRIPT="battery_notify.sh"
TIMER="battery.timer"
SERVICE="battery.service"
PLACE_HOLDER="https://www.fillmurray.com/128/128"

function fetch_file {
	printf 'Fetching '$1'...'
	curl -fsL $GITURL$1 > /tmp/$1
	if [ $? != 0 ]; then echo 'failed'; exit 1; fi
	echo 'success'
}

fetch_file $SCRIPT
fetch_file $TIMER
fetch_file $SERVICE
curl -fsL $PLACE_HOLDER > /tmp/fillmurray.png

mkdir -p $HOME/.config/systemd/user/
mkdir -p $HOME/bin/
mv -i /tmp/$SCRIPT $HOME/bin/
mv -i /tmp/$TIMER /tmp/$SERVICE $HOME/.config/systemd/user/

chmod +x $HOME/bin/$SCRIPT

systemctl --user enable $TIMER
systemctl --user start $TIMER

echo 'Installation successful (you should change the icon in battery_notify.sh)'