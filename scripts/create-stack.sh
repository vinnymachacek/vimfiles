#!/bin/bash -xv 

DATE=$(date +%Y-%m-%d-%H%M%S)
FILE=$( echo $1| sed 's#.params$##g')
FILENAMEANDEXT="${FILE##*/}"
FILENAME="${FILENAMEANDEXT%.*}"
FILEPATH=$(dirname $FILE)
FILEEXT="${FILE##*.}"


aws cloudformation create-stack \
        --stack-name "$( echo ${FILENAME}|tr -d '[:punct:]')-${DATE}" \
        --template-body file://${FILE} \
        --parameters file://${FILENAMEANDEXT}.params \
        --disable-rollback \
        --timeout-in-minutes 10 \
        --capabilities CAPABILITY_IAM
