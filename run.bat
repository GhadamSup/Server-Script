#!/bin/bash

# Set the path to your Minecraft server JAR file
SERVER_PATH=/path/to/minecraft_server.jar

# Set the amount of RAM you want to allocate to the server
RAM=2G

# Stop the server if it's already running
if pgrep -f $SERVER_PATH > /dev/null; then
    echo "Stopping Minecraft server..."
    screen -S minecraft -X stuff "stop^M"
    sleep 5
fi

# Start the server in a screen session
echo "Starting Minecraft server..."
screen -dmS minecraft java -Xmx$RAM -Xms$RAM -jar $SERVER_PATH nogui

# Schedule a server reload in 24 hours using cron
echo "Scheduling server reload in 24 hours..."
(crontab -l ; echo "0 0 * * * screen -S minecraft -X stuff \"stop^M\" && sleep 5 && screen -dmS minecraft java -Xmx$RAM -Xms$RAM -jar $SERVER_PATH nogui") | crontab -

echo "Minecraft server is running!"
