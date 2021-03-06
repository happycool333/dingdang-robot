#!/bin/bash
sleep 1

# tmux session name
session_name="dingdang"

#Delete Cache
sudo rm -r /root/.cache
sudo rm -r /root/.netease-musicbox
sudo rm -r /root/userInfo
sleep 1

#Update dingdang-robot
cd /home/pi/dingdang
git pull

#Update dingdang-contrib
cd /home/pi/.dingdang/contrib
git pull

#Update dingdang-contrib Requirements
sudo pip install --upgrade -r requirements.txt
sleep 1

#Restore Configuration of AlsaMixer
if [ -f /home/pi/asound.state ]; then
    alsactl --file=/home/pi/asound.state restore
    sleep 1
fi

#Launch Dingdang in tmux
sudo tmux new-session -d -s $session_name $HOME/dingdang/dingdang.py
sleep 1

#Start Respeaker-Switcher in Background
if [ -d /home/pi/ReSpeaker-Switcher]; then
    sudo python /home/pi/ReSpeaker-Switcher/switcher.py &
fi
