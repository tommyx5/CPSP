#!/usr/bin/env bash
echo "Create network..."
docker network create cps-net

echo "Starting MQTT Broker..."
docker run -d -p 127.0.0.1:8883:1883 --net=cps-net --name mqttbroker \
  eclipse-mosquitto:1.6.13

echo "Starting Tick Generator..."
docker run -d --net=cps-net --name tick_gen tick_gen:0.1

echo "Starting dashboard..."
docker run -d -p 127.0.0.1:1880:1880 --net=cps-net --name dashboard dashboard:0.1

echo "Starting Choas Sensor..."
docker run -d --net=cps-net --name chaos_sensor1 chaos_sensor1:0.1

echo "Starting Choas Sensor..."
docker run -d --net=cps-net --name chaos_sensor2 chaos_sensor2:0.1

echo "Starting Choas Sensor..."
docker run -d --net=cps-net --name chaos_sensor3 chaos_sensor3:0.1

echo "Starting Choas Sensor..."
docker run -d --net=cps-net --name chaos_sensor4 chaos_sensor4:0.1

echo "Starting calc_avg..."
docker run -d --net=cps-net --name avg_calc avg_calc:0.1
