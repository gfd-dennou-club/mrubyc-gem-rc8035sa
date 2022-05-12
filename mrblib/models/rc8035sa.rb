# coding: utf-8
# RTC: EPSON RX-8035SA
#
# I2C address : 0x32

class RX8035SA

  def initialize(i2c)
    @i2c = i2c
    @i2c.write(0x32, [0xE0, 0x00, 0x00])
    sleep 0.1
  end

  def read
    a = @i2c.readfrom(0x32, 8)   # 8 バイト分読み込み
    ctrl2 = a.shift

    data = Array.new
    i = 0
    [a[6], a[5], a[4], a[3], 0x3f & a[2], a[1], a[0], ctrl2].each do |num|
      data[i] = sprintf('%02x', num)
      i += 1
    end    
    return data
  end

  def write( idate )

    date = Array.new
    # BCD データへの変換
    i = 0
    idate.each do |num|
      date[i] = (num / 10).to_i(2) << 4 | (num % 10).to_i(2)
      i += 1
    end
    
    @i2c.write(0x32, [0x00, date[6], date[5], 0x80 | date[4], date[3], date[2], date[1], date[0]])
    sleep 0.1
    @i2c.write(0x32, [0xF0, 0x00])
    sleep 0.1
  end
end
