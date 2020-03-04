#!/bin/bash
while [[ true ]]; do
	echo Creator: Isakov Denis
	echo This program is designed to output number of files in the catalog which belongs to the user.
	echo Current catalog is
	pwd
	echo List of all users:
	cut -d: -f1 /etc/passwd
	echo Which user do you want to check? Please, type the username.
	user_value=0
until [ $user_value -eq 1 ]; do	#loopcheck for username
read -p "Username input:" user_check
user_value=$(grep -w -c "$user_check" /etc/passwd) #поиск со строгим соответствием и при нахождении счетчик изменяет значение себя и переменной на 1
if [ $user_value -eq 1 ]; then #result output
	echo User $user has been found!
else echo Error, user not found! Please, choose another user or check the spelling.
fi
done

echo "Which directory do you want to check? Type the name with dot before it (eg. ".local")"
cp_switch=0
until [[  $cp_switch -eq 1 ]]; do #loopcheck for directory search
read -p "Input Selection:" ctlg
		if [[ -d "$ctlg" ]]		#checking if existence of directory is True
		then
			echo  "$ctlg exists on your filesystem."
			cp_switch=1
		else echo Directory not found, check the typing and try again.
		fi
	done

if [ $cp_switch -eq 1 ]; then		#search and show all directories with that name in system under current directory
	find . -type d -name "$ctlg"
fi

echo "Please, type full path to the directory. Catalog included." #input full path to directory
read -p "Input Selection:" cat_path
find $cat_path -user $user_check

echo "Do you want to continue? (y/n)"
cont_scr=a
until [[ "$cont_scr" = "y" ]]; do
read -n1 -p "y/n:" cont_scr
	case $cont_scr	in
		y )
echo "Script will continue"
;;
n )
echo "Thanks for using the script"
exit 0
;;
* )
echo "Incorrect output, try again"
;;		
esac
done

done
