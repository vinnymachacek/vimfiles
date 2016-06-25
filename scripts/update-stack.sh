#!/bin/bash 

DATE=$(date +%Y-%m-%d-%H%M%S)
FILE=$( echo $1| sed 's#.params$##g')
FILENAMEANDEXT="${FILE##*/}"
FILENAMEPUNCT="${FILENAMEANDEXT%.*}"
FILENAME=$( echo ${FILENAMEPUNCT}|tr -d '[:punct:]')
FILEPATH=$(dirname $FILE)
FILEEXT="${FILE##*.}"


STACK=$(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE ROLLBACK_COMPLETE UPDATE_COMPLETE UPDATE_ROLLBACK_COMPLETE | jq ".[]|.[]| select(.StackId | contains(\"$FILENAME\"))"| jq '({ StackId: .StackId, Time: (.LastUpdatedTime //.CreationTime )})'| jq -sr 'max_by(.Time) | .StackId')


aws cloudformation update-stack \
        --stack-name "${STACK}" \
        --template-body file://${FILE} \
        --parameters file://${FILENAMEANDEXT}.params \
        --no-use-previous-template \
        --capabilities CAPABILITY_IAM
