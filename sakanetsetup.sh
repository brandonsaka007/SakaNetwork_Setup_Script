#!/bin/bash
isbrandonfile=/tmp/isbrandonauser
brandonisuser=0
key=/tmp/key
userdir=/home/brandon

#SakaNetwork auto config script
#by Brandon

function pause(){
   read -p "$*"
}

echo --------------------------------------------------
echo SAKANETWORK AUTO INSTALL SCRIPT
echo --------------------------------------------------
echo I need sudo:
sudo echo SUDO AUTHENTICATED
echo "This script will install Brandon's favorite utilities and configure an SSH server."
echo "If the user 'brandon' exists, the script will fech a public key form the internet and install it to the user 'brandon'"
pause 'Press [Enter] key to continue...'


echo Starting................

#apt-get installs
sudo apt-get update
sudo apt-get install vim ssh wget

#ssh setup
sudo service ssh restart

#Is 'brandon' a user?
sudo cat /etc/passwd | grep home/brandon:/bin/bash | cut -d: -f1 > $isbrandonfile
grep -Fx brandon $isbrandonfile > /dev/null


#Set up "brandon"
if [ $? -eq 0 ]
  then
    echo "User 'brandon' found:"
    sudo mkdir $userdir/.ssh
    sudo wget -q https://sakaserver.com/fech/authorized_keys -O $key
    sudo rm -rf $userdir/.ssh/
    sudo mkdir $userdir/.ssh/
    sudo cp $key $userdir/.ssh/authorized_keys
    #sudo chmod 700 /home/brandon/.ssh
    #udo chmod 600 /home/brandon/.ssh/authorized_keys
    sudo adduser brandon sudo
  #brandon is a user
      brandonisuser=1
  else
    echo "User 'brandon' not found skiping:"
      brandonisuser=0
  fi



if [ $brandonisuser = 1 ]
then
  echo BRANDON HAS BEEN SET UP
  #display current server info
  #server ip

else
echo
fi

#display current server info
#server ip
echo Server IP:
sudo ifconfig | grep --color "inet addr:"


#cleanup
sudo rm -rf $isbrandonfile
sudo rm -rf $key
