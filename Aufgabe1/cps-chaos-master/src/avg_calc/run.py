import sys
import json
import logging
from mqtt.mqtt_wrapper import MQTTWrapper

# MQTT topic for publishing sensor data
CHAOS_DATA_TOPIC = "chaossensor/avg/data"

# MQTT topic for receiving tick messages
DATA_TOPIC = "chaossensor/tmp/data"
LENGTH = 42
RECEIVED_DATA = []
for i in range(LENGTH):
	RECEIVED_DATA.append(0)
POS = 0

def on_message_tick(client, userdata, msg):
    """
    Callback function that processes messages from the tick generator topic.
    It generates a random sensor value and publishes it along with the tick's timestamp.
    
    Parameters:
    client (MQTT client): The MQTT client instance
    userdata: User-defined data (not used here)
    msg (MQTTMessage): The message containing the tick timestamp
    """
    global CHAOS_DATA_TOPIC
    global RECEIVED_DATA
    global POS
    
    avg = 0
    payload = json.loads(msg.payload) 
    timestamp = payload["timestamp"]
    RECEIVED_DATA[POS] = payload["payload"]
    POS = (POS + 1)%LENGTH
    #RECEIVED_DATA.append(value)
    if len(RECEIVED_DATA) > 0:
        for val in RECEIVED_DATA:
            avg += val
        avg = avg // len(RECEIVED_DATA)
    data = {"payload": avg, "timestamp": timestamp}
    
    client.publish(CHAOS_DATA_TOPIC, json.dumps(data))
    
    

def main():
    """
    Main function to initialize the MQTT client, set up subscriptions, 
    and start the message loop.
    """
    
    # Initialize the MQTT client and connect to the broker
    mqtt = MQTTWrapper('mqttbroker', 1883, name='avg_calc')
    
    # Subscribe to the DATA_TOPIC
    mqtt.subscribe(DATA_TOPIC)
    # Subscribe with a callback function to handle incoming DATA_TOPIC messages
    mqtt.subscribe_with_callback(DATA_TOPIC, on_message_tick)
    
    try:
        # Start the MQTT loop to process incoming and outgoing messages
        mqtt.loop_forever()
    except (KeyboardInterrupt, SystemExit):
        # Gracefully stop the MQTT client and exit the program on interrupt
        mqtt.stop()
        sys.exit("KeyboardInterrupt -- shutdown gracefully.")

if __name__ == '__main__':
    # Entry point for the script
    main()
