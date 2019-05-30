class Award

  attr_reader :name
  attr_accessor :expires_in, :quality
 
  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality

    @strategies = {}
    @strategies['Blue Compare'] = BlueCompareAward
    @strategies['Blue Distinction Plus'] = BlueDistinctionPlusAward
    @strategies['Blue First'] = BlueFirstAward
    @strategies['Blue Star'] = BlueStarAward
    @strategies['NORMAL ITEM'] = NormalItemAward
  end

  def update
    strategy = @strategies[@name]
    strategy.update(self)
  end
end

class BlueCompareAward
  def self.update(context)
    context.quality += 1 if context.quality < 50
    context.quality += 1 if context.expires_in < 11 && context.quality < 50
    context.quality += 1 if context.expires_in < 6 && context.quality < 50
    context.expires_in -= 1
    context.quality = context.quality - context.quality if context.expires_in < 0
  end
end

class BlueDistinctionPlusAward
  def self.update(context)
  end
end

class BlueFirstAward
  def self.update(context)
    context.quality += 1 if context.quality < 50
    context.expires_in -= 1
    context.quality += 1 if context.expires_in < 0 && context.quality < 50
  end
end

class BlueStarAward
  def self.update(context)
    context.quality -= 2 if context.expires_in > 0 && context.quality.between?(1,50)
    context.quality -= 4 if (context.expires_in == 0 || context.expires_in < 0) && context.quality.between?(4,50)        
    context.expires_in -= 1
  end
end

class NormalItemAward
  def self.update(context)
    context.quality -= 1 if context.expires_in > 0 && context.quality.between?(1,50)
    context.quality -= 2 if (context.expires_in == 0 || context.expires_in < 0) && context.quality < 50
    context.expires_in -= 1
  end
end