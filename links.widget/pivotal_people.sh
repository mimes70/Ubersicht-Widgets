#!/bin/bash
source "links.widget/enviroment.sh"

TOKEN=$PT_TOKEN

RESULT=$(echo `links.widget/pivotal_geek.sh`)
if [ -n "$RESULT" ]; then
	echo "Mesquita :"
	OIFS=$IFS
	IFS='!'
	for i in $RESULT; do
		echo "       $i"
	done
	IFS=$OIFS
fi


#echo -n "Pivotal Started, "
#date "+%d %h %H:%M"
declare -a PROJECT_NAME=('RecordM' 'DeviceM' 'WorkM' 'Commons' 'Sigre' 'Clientes');
declare -a USERS=('mimes' 'joba' 'jone' 'JFelix');
export LANG=C
for USER in  "Mesquita" "Barata" "Nelas" "Felix"
do
	if [ "$USER" != "Mesquita" ]; then
		echo $USER ":"
	fi
	PROJ_NUMBER=0
	for PROJECT in "269583" "87999" "483673" "343261" "585459" "324969"
	do
		URL='https://www.pivotaltracker.com/services/v3/projects/'$PROJECT'/stories?filter=state%3Astarted%20owned_by%3A'$USER
		CMD='curl -X GET -H "X-TrackerToken:'$TOKEN'" -H "Content-type:application/xml" '$URL
		RESULT=$(eval $CMD" 2>/dev/null | grep '<name>' | sed -e 's/\<\/name/#\</g' | sed -e 's/\<[^\>]*\>//g' | tr -s ' ' | tr -d '\n'")

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
