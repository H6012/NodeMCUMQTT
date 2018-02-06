 --dp.lua
print("script1 running...")
pin = 5
last_state = 1
gpio.mode(5, gpio.INPUT)
tmr.alarm(0,100, 1, function()
    if gpio.read(pin) ~= last_state then
        last_state = gpio.read(pin)
        conn = net.createConnection(net.TCP, 0)
        conn:connect(80,"178.62.29.184")
        conn:on("receive", function(conn, payload) end)
        conn:on("connection", function(conn, payload) 
            if last_state == 1 then
                conn:send("GET /json.htm?type=command&param=switchlight&idx=YOURSENSORIDX&switchcmd=Set%20Level&level=10"
                .." HTTP/1.1\r\n" 
                .."Host: 127.0.0.1:8080\r\n"
                .."Connection: close\r\n"
                .."Accept: */*\r\n" 
                .."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n" 
                .."\r\n")
                print("ON")
            else
                conn:send("GET /json.htm?type=command&param=switchlight&idx=YOURSENSORIDX&switchcmd=Set%20Level&level=0"
                .." HTTP/1.1\r\n" 
                .."Host: 127.0.0.1:8080\r\n"
                .."Connection: close\r\n"
                .."Accept: */*\r\n" 
                .."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n" 
                .."\r\n")
                print("OFF")
            end
        end) 
        conn:on("disconnection", function(conn, payload) end)
        end
    end)