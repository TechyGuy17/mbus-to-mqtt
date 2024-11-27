#!/usr/bin/bash
CONFIG_PATH=/data/options.json

METERS=$(jq --raw-output '.mbus_address // empty' $CONFIG_PATH)
PORT=$(jq --raw-output '.mbus_gateway_port // empty' $CONFIG_PATH)
DEVICE=$(jq --raw-output '.mbus_gateway // empty' $CONFIG_PATH)
MQTT_HOST=$(jq --raw-output '.mqtt_host // empty' $CONFIG_PATH)
MQTT_USER=$(jq --raw-output '.mqtt_user // empty' $CONFIG_PATH)
MQTT_PASS=$(jq --raw-output '.mqtt_pass // empty' $CONFIG_PATH)
MQTT_TOPIC=$(jq --raw-output '.mqtt_topic // empty' $CONFIG_PATH)

METERARRAY=($(echo $METERS | tr ";" "\n"))

echo -e "\n $(date)"
echo "Sending data to host $MQTT_HOST as user '$MQTT_USER' using topic '$MQTT_TOPIC/'."

for METER in "${METERARRAY[@]}"
do
    echo -n "Getting data from $METER..."
    # The sed is for replacing the @ with _ to be able to match on it in HASS templates
    METER_DATA=$(mbus-tcp-request-data-multi-reply $DEVICE $PORT $METER | xq . | sed -e "s/@/_/")
    mosquitto_pub -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASS \
        -t $MQTT_TOPIC/$METER -m "${METER_DATA}"
    BYTCNT=$(echo "$METER_DATA" | wc -c)
    echo "  $BYTCNT bytes sent"
done

    
