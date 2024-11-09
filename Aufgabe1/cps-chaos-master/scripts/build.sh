#!/usr/bin/env bash
BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/../src/"

docker build ${BASE_DIR}tick_gen -t tick_gen:0.1
echo -e "\n\n"

docker build ${BASE_DIR}chaos_sensor1 -t chaos_sensor1:0.1
echo -e "\n\n"

docker build ${BASE_DIR}chaos_sensor2 -t chaos_sensor2:0.1
echo -e "\n\n"

docker build ${BASE_DIR}chaos_sensor3 -t chaos_sensor3:0.1
echo -e "\n\n"

docker build ${BASE_DIR}chaos_sensor4 -t chaos_sensor4:0.1
echo -e "\n\n"

docker build ${BASE_DIR}avg_calc -t avg_calc:0.1
echo -e "\n\n"

docker build ${BASE_DIR}dashboard -t dashboard:0.1
echo -e "\n\n"
