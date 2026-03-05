#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | grep -v '^#' | xargs)
else
  echo "Error: .env file not found. Please copy .env.example to .env and fill in your credentials."
  exit 1
fi

docker run --rm -u zap \
  -e EVERGREEN_USER -e EVERGREEN_PASS \
  -v "$(pwd)":/zap/wrk/:rw \
  zaproxy/zap-stable \
  zap.sh -cmd -autorun /zap/wrk/zap.yaml

