#!/bin/bash
source "links.widget/enviroment.sh"
TOKEN=$PT_TOKEN

declare -a PROJECT_NAME=('RecordM' 'DeviceM' 'WorkM' 'Commons' 'Sigre' 'Clientes')
export LANG=C
for USER in  "Mesquita" "Barata" "Nelas" "Felix"
do
	echo $USER ":"
	PROJ_NUMBER=0
	for PROJECT in "269583" "87999" "483673" "343261" "585459" "324969"
	do
		URL='https://www.pivotaltracker.com/services/v3/projects/'$PROJECT'/stories?filter=state%3Astarted%20owned_by%3A'$USER
		CMD='curl -X GET -H "X-TrackerToken:'$TOKEN'" -H "Content-type:application/xml" '$URL
		RESULT=$(eval $CMD" 2>/dev/null | grep '<name>' | sed -e 's/\<\/name/#\</g' | sed -e 's/\<[^\>]*\>//g' | tr -s ' ' | tr -d '\n'")

		RESULT2=""
		if [ "$USER" == "Mesquita" ]; then
			URL='https://www.pivotaltracker.com/services/v3/projects/'$PROJECT'/stories?filter=state%3Adelivered'
			#idealmente o filtro seria filter=state%3Adelivered%20-label%3Ano_test mas o - não está suportado na api
			CMD='curl -X GET -H "X-TrackerToken:'$TOKEN'" -H "Content-type:application/xml" '$URL
			RESULT2=$(eval $CMD" 2>/dev/null | grep '<name>' | sed -e 's/\<\/name/#\</g' | sed -e 's/\<[^\>]*\>//g' | tr -s ' ' | tr -d '\n'")

			OIFS=$IFS
			IFS='#'
			for i in $RESULT2; do
				if [ -n "$i" ]; then
					RSLT=$(echo "TEST: ${PROJECT_NAME[$PROJ_NUMBER]} - $i" | perl -C -pe 's/&\#(\d+);/chr($1)/ge' )
					echo "       $RSLT"
					TASK=$(echo $RSLT | iconv -t MACROMAN -f UTF8-MAC)
					export TASK

					APPSCPTRSLT="$(osascript <<<'
						tell application "Things3"
							set TASK to system attribute "TASK"
							set todayToDos to to dos of list "Anytime" & to dos of list "Inbox"
							set flagCreate to true
							repeat with todayToDo in todayToDos
								if name of todayToDo is TASK then
									set flagCreate to false
								end if
							end repeat
							if flagCreate then
								set taskName to TASK
								set taskNotes to ""
								set newToDo to make new to do with properties {name:taskName, notes:taskNotes} at beginning of list "Today"
							end if
						end tell
					')"
				fi
			done
			IFS=$OIFS
		fi

		OIFS=$IFS
		IFS='#'
		for i in $RESULT; do
			if [ -n "$i" ]; then
 				echo -n "       ${PROJECT_NAME[$PROJ_NUMBER]}: "
				echo $(echo "$i" | perl -C -pe 's/&\#(\d+);/chr($1)/ge')
			fi
		done
		IFS=$OIFS
		PROJ_NUMBER=$(( $PROJ_NUMBER + 1 ))
	done
done
