-- initialize mqtt client with keepalive timer of 60sec
m = mqtt.Client("CLIENTID", 60, "", "") -- Living dangerously. No password!

-- When client  c onnects, print status message and subscribe to cmd topic
m:on("connect", function(m) 
    -- Serial status message
    print (" connected to MQTT host \n\n")

    -- Subscribe to the topic where the ESP8266 will get commands from
    m:subscribe("/mcu/cmd/#", 0,
        function(m) print("Subscribed to CMD Topic") end)
end) 


m:on("message", function(m,t, pl) 
    -- Serial status message
    print (" got Message " )
    print("PAYLOAD: ", pl)
    print("TOPIC: ", t)
   
   if pl~=nil then
        if pl == "1" then
            print("ON")
            gpio.mode(4, gpio.OUTPUT)
            gpio.write(4, 1)
        else
            print("OFF")
            gpio.mode(4, gpio.OUTPUT)
            gpio.write(4, 0)
        end

    end 

    -- Subscribe to the topic where the ESP8266 will get commands from
   
end)

-- Set up Last Will and Testament (optional)
-- Broker will publish a message with qos = 0, retain = 0, data = "offline"
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("/lwt", "Oh noes! Plz! I don't wanna die!", 0, 0)


-- Connect to the broker
m:connect("178.62.29.184", 1883, 0, 1)

 
 


tmr.alarm(0,5000, 1, function()

    local adc = adc.read(0);

    msg = "Light Level " .. tostring(adc)
  
    --msg = "Light="
    
    m:publish("/mcu/rgbled_status/", msg, 0, 0,
            function(m) print("ANIMATE COMMAND") end)
    
    print (" publishing.... ")        
    end)
