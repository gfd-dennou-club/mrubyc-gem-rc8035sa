# coding: utf-8

#I2C 初期化
i2c = I2C.new(22, 21)

# RTC 初期化. 時刻設定
rtc = RX8035SA.new(i2c)
rtc.write([0x20, 0x03, 0x31, 1, 0x23, 0x59, 0x50]) #年(下2桁), 月, 日, 曜日, 時, 分, 秒

while true
  tt = rtc.read
  puts sprintf("%02x-%02x-%02x", tt[0], tt[1], tt[2])
  puts sprintf("%02x:%02x:%02x", tt[4], tt[5], tt[6])
  puts ""
  sleep 1.0
end
