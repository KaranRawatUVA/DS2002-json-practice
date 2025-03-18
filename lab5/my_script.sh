#!/bin/bash

curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbox=40%2C-90%2C45%2C-85" > aviation.json

# recipt time
mapfile -t time1 < <(jq -r '.[] | .receiptTime' aviation.json)

for (( i=0; i<6; i++ )); do
  echo "${time1[$i]}"
done


# average temp
avgTemp=0
mapfile -t temp < <(jq -r '.[] | .temp' aviation.json)
for (( i=0; i<${#temp[@]}; i++ )); do
  avgTemp=$(awk "BEGIN {print $avgTemp + ${temp[$i]}}")
done
count=${#temp[@]}
average=$(awk "BEGIN {print $avgTemp / $count}")

echo "Average Temperature: $average"


# Mostly Cloudy
count=0
mapfile -t clouds < <(jq -r '.[] | .clouds[].cover' aviation.json)

for (( i=0; i<12; i++ )); do
    if [ "${clouds[$i]}" != "CLR" ]; then
        count=$((count + 1))
    fi
    echo "${clouds[$i]}"
done

#echo "$count"

cloudy="false"
if [ "$count" -gt "6" ]; then    
    cloudy="true"
fi
echo "Mostly Cloudy: $cloudy" 

