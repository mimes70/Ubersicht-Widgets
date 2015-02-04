#!/bin/bash
source "links.widget/enviroment.sh"

#Request
#echo -n "Ligthhouse, "
##date "+%d %h %H:%M:%S"
NEW=$(curl -H "X-LighthouseToken: $LH_TOKEN" https://cob.lighthouseapp.com/projects/70149/bins/346069.xml 2>/dev/null | grep "tickets-count"  | sed -e 's/^.*>\(.*\)<.*$/\1 /g')
NEW2=$(curl -H "X-LighthouseToken: $LH_TOKEN" https://cob.lighthouseapp.com/projects/70911/bins/347835.xml 2>/dev/null | grep "tickets-count"  | sed -e 's/^.*>\(.*\)<.*$/\1 /g')
TOTAL=`expr $NEW + $NEW2`
if [[ $TOTAL -eq 1 ]]; then
	$(say -v Joana "Atenção, 1 tícate novo")
elif [[ $TOTAL -gt 1 ]]; then
	$(say -v Joana "Atenção, $TOTAL tícates novos")
fi
echo PT: $NEW
echo LIDL: $NEW2
