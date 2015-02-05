#!/bin/bash

#USAGE: ./test.sh --token=XXXX --project=269583 --story=15816779 --template=sigre.template --release=1.2.3
source "links.widget/enviroment.sh"

TOKEN=$PT_TOKEN
PROJ_NUMBER=0
#echo -n "Pivotal to test, "
#date "+%d %h %H:%M"
declare -a PROJECT_NAME=('RecordM' 'DeviceM' 'WorkM' 'Commons' 'Sigre' 'Clientes');
for PROJECT in "269583" "87999" "483673" "343261" "585459" "324969"
do
	URL='https://www.pivotaltracker.com/services/v3/projects/'$PROJECT'/stories?filter=state%3Adelivered'
	#idealmente o filtro seria filter=state%3Adelivered%20-label%3Ano_test mas o - não está suportado na api
	CMD='curl -X GET -H "X-TrackerToken:'$TOKEN'" -H "Content-type:application/xml" '$URL
	RESULT=$(eval $CMD" 2>/dev/null | grep '<story>'  | wc -l ")

	if [ $RESULT -ne 0 ]; then
 		echo  "${PROJECT_NAME[$PROJ_NUMBER]}: $RESULT!"
	fi
	PROJ_NUMBER=$(( $PROJ_NUMBER + 1 ))
done
