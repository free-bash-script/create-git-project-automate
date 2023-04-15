#!/bin/bash
########################################################################
#                            Git Program                               #
#                      Author: Mehdi Abdollahi                         #
#                          Date: 1401/11/17                            #
########################################################################
############### The components that display the menu ###################
items=("Create Git Project " "Add User To Project")
echo -e "\t\tWelcome to Git Program \n\t\tWhat do you want to do?"
select item in "${items[@]}" Quit
do
#### It is determined what script should be issued by each option #####
    case $REPLY in
        1) bash /u01/scripts/git-program/git_program_menu_1.sh;;
        2) bash /u01/scripts/git-program/git_program_user_access_menu_2.sh;;
        $((${#items[@]}+1))) echo "See You Later:))"; break;;
        *) echo "Ooops - unknown choice $REPLY";;
    esac
done