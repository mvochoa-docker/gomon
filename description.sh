#!/bin/sh

# Set the default path to README.md
TAG=$(echo $CI_JOB_NAME | sed 's/.*:/\1/')
SED="s/\]($TAG/\]($(echo $CI_PROJECT_URL | sed 's/\//\\\//g')\/-\/blob\/master\/$TAG/g"
cat README.md | sed $SED > DESCRIPTION.md
README_FILEPATH=${README_FILEPATH:="./DESCRIPTION.md"}

# Check the file size
if [ $(wc -c <${README_FILEPATH}) -gt 25000 ]; then
  echo "File size exceeds the maximum allowed 25000 bytes"
  exit 1
fi

# Acquire a token for the Docker Hub API
echo "Acquiring token"
LOGIN_PAYLOAD="{\"username\": \"${CI_DOCKER_USER}\", \"password\": \"${CI_DOCKER_PASSWORD}\"}"
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d "${LOGIN_PAYLOAD}" https://hub.docker.com/v2/users/login/ | jq -r .token)

# Send a PATCH request to update the description of the repository
echo "Sending PATCH request"
REPO_URL="https://hub.docker.com/v2/repositories/$1/"
RESPONSE_CODE=$(curl -s --write-out %{response_code} --output /dev/null -H "Authorization: JWT ${TOKEN}" -X PATCH --data-urlencode full_description@${README_FILEPATH} ${REPO_URL})
echo "Received response code: $RESPONSE_CODE"

if [[ "$RESPONSE_CODE" == "200" ]]; then
  exit 0
else
  exit 1
fi
