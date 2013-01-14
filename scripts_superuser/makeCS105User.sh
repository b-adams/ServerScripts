#!/bin/bash

if [[ $UID -ne 0 ]]; then echo "Please run $0 as root." && exit 1; fi

if [ $# -ne 3 ]
  then
    echo "$0 USERNAME FULLNAME PASSWORD"
    exit 1
fi

USERNAME=$1
FULLNAME=$2
PASSWORD=$3

# Find out the next available user ID
MAXID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)
USERID=$((MAXID+1))

echo "Creating $USERNAME (#$USERID : $FULLNAME ) with password $PASSWORD"

# Create the user account
dscl . -create /Users/$USERNAME
dscl . -create /Users/$USERNAME UserShell /bin/bash
dscl . -create /Users/$USERNAME RealName "$FULLNAME"
dscl . -create /Users/$USERNAME UniqueID "$USERID"
dscl . -create /Users/$USERNAME PrimaryGroupID 507
#20 is staff, 507 is webuser
dscl . -create /Users/$USERNAME NFSHomeDirectory /Users/cs105/$USERNAME

#dscl . -passwd /Users/$USERNAME $PASSWORD

# Create the home directory
#createhomedir -c > /dev/null
mkdir /Users/cs105/$USERNAME
mkdir /Users/cs105/$USERNAME/wwwroot
mkdir /Users/cs105/$USERNAME/Sites

# Create project stubs
cp ./cs105/contents.php /Users/cs105/$USERNAME/wwwroot/index.php
cp ./cs105/stub_index.php /Users/cs105/$USERNAME/Sites/index.php
cp ./cs105/stub_architecture.html /Users/cs105/$USERNAME/Sites/architecture.html
cp ./cs105/stub_proposal.html /Users/cs105/$USERNAME/Sites/proposal.html

chown -R $USERNAME /Users/cs105/$USERNAME/

ln -s /Users/cs105/$USERNAME/wwwroot/ /Users/software/Sites/cs105/$USERNAME
ln -s /Users/cs105/$USERNAME/Sites/ /Users/cs105/$USERNAME/wwwroot/project

# Create web password
htpasswd -b /Users/software/SiteAccess/.passwords $USERNAME $PASSWORD

# Create .htaccess file
sed s/astudent/$USERNAME/ <./cs105/htaccess.stub >/tmp/$USERNAME.htaccess
mv /tmp/$USERNAME.htaccess /Users/cs105/$USERNAME/wwwroot/.disabled.htaccess

echo ".htaccess and web starter material set up"
passwd $USERNAME
