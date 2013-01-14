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

chown -R $USERNAME /Users/$USERNAME/
