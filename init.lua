--init.lua
wifi.setmode(wifi.STATION)

station_cfg={}
station_cfg.ssid="NetworkName"
station_cfg.pwd="NetworkPassword"
station_cfg.save=true
wifi.sta.config(station_cfg)


wifi.sta.connect()
tmr.alarm(1, 1000, 1, function()
    if wifi.sta.getip() == nil then
        print("IP unavaiable, Waiting...")
    else
        tmr.stop(1)
        print("ESP8266 mode is: " .. wifi.getmode())
        print("The module MAC address is: " .. wifi.ap.getmac())
        print("Config done, IP is "..wifi.sta.getip())
        dofile ("script4.lua")
    end
end)