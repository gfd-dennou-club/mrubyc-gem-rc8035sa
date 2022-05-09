# mrubyc-gem-rx8035sa
mruby/c sources for rx8035sa (Real Time Clock)

## device
https://www5.epsondevice.com/ja/products/rtc/rx8035sa.html

### data sheet
+ http://akizukidenshi.com/download/ds/seikoepson/rx-8035_am.pdf
+ https://support.epson.biz/td/api/doc_check.php?dl=app_RX-8035SA

## sample

```ruby
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
```
