#!/usr/bin/env sh

cd ./services || exit 1

python3 apiService.py --host="${COMPONENT_NAME}" --port=8080 &
# Sleep is needed to let db be populated in a non-overlapping fashion
sleep 5

python3 diameterService.py &
# Sleep is needed to let db be populated in a non-overlapping fashion
sleep 5

python3 hssService.py
