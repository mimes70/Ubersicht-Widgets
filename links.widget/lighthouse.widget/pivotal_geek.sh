#!/bin/bash

#USAGE: ./test.sh --token=XXXX --project=269583 --story=15816779 --template=sigre.template --release=1.2.3

TOKEN="2274b9814882fa5c72dff52570b42cd2"
PROJ_NUMBER=0
#echo -n "Pivotal to test, "
#date "+%d %h %H:%M"
declare -a PROJECT_NAME=('DeviceM' 'RecordM' 'Sigre' 'LIDL' 'Commons' 'WorkM' 'Sigre V4' 'PT COM'i 'Internal');
for PROJECT in "87999" "269583" "267403" "324969" "343261" "483673" "585459" "880850" "1021222"
do
	URL='https://www.pivotaltracker.com/services/v3/projects/'$PROJECT'/stories?filter=state%3Adelivered'
	CMD='curl -X GET -H "X-TrackerToken:'$TOKEN'" -H "Content-type:application/xml" '$URL
	RESULT=$(eval $CMD" 2>/dev/null | grep '<story>'  | wc -l ")

	if [ $RESULT -ne 0 ]; then
 		echo  "${PROJECT_NAME[$PROJ_NUMBER]}: $RESULT!"
	fi
	PROJ_NUMBER=$(( $PROJ_NUMBER + 1 ))
done
