#!/bin/bash

GITURL="https://raw.githubusercontent.com/armandmgt/dotfiles/master/systemd/"
SCRIPT="battery_notifier.sh"
TIMER="battery.timer"
SERVICE="battery.service"

curl -fL $GITURL$SCRIPT > /tmp/$SCRIPT
if [ $? != 0 ]; then exit 1; fi
curl -fL $GITURL$TIMER > /tmp/$TIMER
if [ $? != 0 ]; then exit 1; fi
curl -fL $GITURL$SERVICE > /tmp/$SERVICE
if [ $? != 0 ]; then exit 1; fi

mkdir -p $HOME/.config/systemd/user/
mkdir -p $HOME/bin/
mv -i /tmp/$SCRIPT $HOME/bin/
mv -i /tmp/$TIMER /tmp/$SERVICE $HOME/.config/systemd/user/

chmod +x $HOME/bin/$SCRIPT

systemctl --user enable $TIMER
systemctl --user start $TIMER
