class Award

  attr_reader :name
  attr_accessor :expires_in, :quality
 
  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality

    @strategies = {}

    @strategies['Blue Compare'] = 
    -> { @quality += 1 if @quality < 50
         @quality += 1 if @expires_in < 11 && @quality < 50
         @quality += 1 if @expires_in < 6 && @quality < 50
         @expires_in -= 1
         @quality = @quality - @quality if @expires_in < 0 }

    @strategies['Blue Distinction Plus'] = -> {}

    @strategies['Blue First'] = 
    -> { @quality += 1 if @quality < 50
         @expires_in -= 1
         @quality += 1 if @expires_in < 0 && @quality < 50 }

    @strategies['Blue Star'] = 
    -> { @quality -= 2 if @expires_in > 0 && @quality.between?(1,50)
         @quality -= 4 if (@expires_in == 0 || @expires_in < 0) && @quality.between?(4,50)        
         @expires_in -= 1 }

    @strategies['NORMAL ITEM'] = 
    -> { @quality -= 1 if expires_in > 0 && @quality.between?(1,50)
         @quality -= 2 if (@expires_in == 0 || @expires_in < 0) && @quality < 50
         @expires_in -= 1 }
  end

  def update
    strategy = @strategies[@name]
    strategy ? strategy.call : nil
  end
end
