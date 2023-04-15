#!/bin/bash
#######################################################################################################
#                                   Git Program                                                       #
#                                   Author: Mehdi Abdollahi                                           #
#                                   Date: 1401/11/17                                                  #
#######################################################################################################


echo -n 'Please Enter "Absolute"  Git Address: '
 read gitaddress
echo -n 'Please Enter Git Name Without .git: '
 read gitname
       
hookaddress='curl http://Jenkins-Server-IP:8080/git/notifyCommit?url=ssh://root@Git-Server-IP'

########################################################################

mkdir -p $gitaddress
        echo
        echo "============================ Git Address Create ============================"

        cd $gitaddress && git init --bare
        echo
        echo

        if [ -s $gitaddress ]
            then echo '============================ Git Repository Create ============================'
        fi

        touch $gitaddress/hooks/post-update && echo "#!/bin/bash" > $gitaddress/hooks/post-update
        echo "$hookaddress$gitaddress" >> $gitaddress/hooks/post-update

########################### Set Pernissions ############################

        chmod g+s $gitaddress
        setfacl -R -d -m g::rwx $gitaddress
        chmod -R 770 $gitaddress
        
########################### Create Git Group ############################       
        
        groupadd git$gitname
            getent group git$gitname
            echo

########################### Set Owner Group #############################
# Function For access avigit
function avigitaccsess() {
        echo -n "Please enter the address where you want avigit to be the group owner: " 
        read avigitacc
        chown -R :avigit $avigitacc
        chown -R :git$gitname $gitaddress
} 

        read -p "New Git Address [y/n] : " avigit
        case $avigit in
                [Y/y] ) avigitaccsess;;
                [N/n] ) chown -R :git$gitname $gitaddress;;
                * ) echo invalid response;;

        esac

########################################################################

        echo
        echo '============================ Create Successfully ============================'
        echo \*hook file Check...
        echo

        cat $gitaddress/hooks/post-update
        echo \*It\'s OK....
        echo
        echo
        echo \*Git Project Check...
        ls -ltrh $gitaddress
        echo
        echo \*It\'s OK....

############################ 1_User Access #############################

        while true; do
                read -p "Please Enter Git User: " gitusername
                searchuser=`cat /etc/passwd | cut -d ":" -f 1 | grep -i $gitusername`
                read -p "Are you sure? $searchuser: [y/n]" ny
        case $ny in
                [Y/y] ) usermod -aG  git$gitname $searchuser;
                        continue;;
                [N/n] ) echo "Next User";
                        continue;;
                * ) echo invalid response;;

        esac
        done
