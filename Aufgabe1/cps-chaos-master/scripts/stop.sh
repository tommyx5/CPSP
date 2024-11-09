#!/usr/bin/env bash

echo "Stopping containers..."
docker stop dashboard
docker stop chaos_sensor1
docker stop chaos_sensor2
docker stop chaos_sensor3
docker stop chaos_sensor4
docker stop avg_calc
docker stop tick_gen
docker stop mqttbroker

echo -e "\nRemoving containers and network...\n"
docker rm dashboard
docker rm chaos_sensor1
docker rm chaos_sensor2
docker rm chaos_sensor3
docker rm chaos_sensor4
docker rm avg_calc
docker rm tick_gen
docker rm mqttbroker
docker network rm cps-net
