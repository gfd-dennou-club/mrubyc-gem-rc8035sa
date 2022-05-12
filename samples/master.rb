# coding: utf-8

#I2C 初期化
i2c = I2C.new(22, 21)

# RTC 初期化. 時刻設定
rtc = RX8035SA.new(i2c)
rtc.write([20, 3, 31, 1, 23, 59, 50]) #年(下2桁), 月, 日, 曜日, 時, 分, 秒

while true
  tt = rtc.read
  puts sprintf("%02d-%02d-%02d", tt[0], tt[1], tt[2])
  puts sprintf("%02d:%02d:%02d", tt[4], tt[5], tt[6])
  puts ""
  sleep 1.0
end
