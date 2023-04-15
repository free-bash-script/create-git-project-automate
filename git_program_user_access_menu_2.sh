#!/bin/bash
########################################################################
#                            Git Program                               #
#                      Author: Mehdi Abdollahi                         #
#                          Date: 1401/11/17                            #
########################################################################
##################### Access User To Git Group #########################
while true; do
        read -p "Please Enter Git User: " gitusername
        read -p "Please Enter Git Group: " gitgroup

################## Find the full name of the user  #####################

searchuser=`cat /etc/passwd | cut -d ":" -f 1 | grep -i $gitusername`

read -p "$searchuser Access to $gitgroup?: [y/n]" ny

################# Create access if admin approves #####################
case $ny in
        [Y/y] ) usermod -aG $gitgroup $searchuser;
                continue;;
        [N/n] ) echo "Please enter a new user";
                continue;;
        * ) echo invalid response;;
esac
done