# mrubyc-gem-rx8035sa
mruby/c sources for rx8035sa (Real Time Clock)

## device
https://www5.epsondevice.com/ja/products/rtc/rx8035sa.html

### data sheet
+ http://akizukidenshi.com/download/ds/seikoepson/rx-8035_am.pdf
+ https://support.epson.biz/td/api/doc_check.php?dl=app_RX-8035SA

## sample code
LCD と RTC を使う場合の例

```ruby
puts "*********************"
puts " I2C check (LCD, RTC)    "
puts "*********************"

#I2C 初期化
i2c = I2C.new()

# LCD 初期化
lcd = AQM0802A.new(i2c)

## RTC 初期化. 時刻設定
rtc = RX8035SA.new(i2c)

# RTC に初期値書き込み
rtc.write([20, 3, 31, 1, 23, 59, 30]) #年(下2桁), 月, 日, 曜日, 時, 分, 秒

# LCD に "Hello World" 表示
lcd.cursor(0, 0)
lcd.write_string("Hello?!")
lcd.cursor(0, 1)
lcd.write_string("from ESP")

sleep(10)

# 適当な時間を表示
while true
  rtc.read  #時刻の読み出し
  t0 = sprintf("%02d-%02d-%02d", rtc.year, rtc.mon, rtc.day)
  t1 = sprintf("%02d:%02d:%02d", rtc.hour, rtc.min, rtc.sec)

  lcd.cursor(0, 0)
  lcd.write_string( t0 )
  lcd.cursor(0, 1)
  lcd.write_string( t1 )

#  puts sprintf("#{t0} #{t1}")
  sleep 0.2
end
```
