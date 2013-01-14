#!/bin/bash

if [[ $UID -ne 0 ]]; then echo "Please run $0 as root." && exit 1; fi

if [ $# -ne 2 ]
  then
    echo "$0 USERNAME FULLNAME"
    exit 1
fi

USERNAME=$1
PASSWORD="changeme"
FULLNAME=$2

# Find out the next available user ID
MAXID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)
USERID=$((MAXID+1))

echo "Creating $USERNAME (#$USERID : $FULLNAME ) with password $PASSWORD"
echo "You will probably need to fix the password"

# Create the user account
dscl . -create /Users/$USERNAME
dscl . -create /Users/$USERNAME UserShell /bin/bash
dscl . -create /Users/$USERNAME RealName "$FULLNAME"
dscl . -create /Users/$USERNAME UniqueID "$USERID"
dscl . -create /Users/$USERNAME PrimaryGroupID 508
#20 is staff, 508 is git_user
dscl . -create /Users/$USERNAME NFSHomeDirectory /Users/$USERNAME

#dscl . -passwd /Users/$USERNAME $PASSWORD

# Create the home directory
#createhomedir -c > /dev/null
mkdir /Users/$USERNAME
mkdir /Users/$USERNAME/cs131
git init /Users/$USERNAME/cs131

cp cs131/base.gitconfig /Users/$USERNAME/.gitconfig

chmod -R g+rw /Users/$USERNAME/cs131
chown -R $USERNAME:508 /Users/$USERNAME/

cp cs131/README.md /Users/$USERNAME/

passwd $USERNAME
