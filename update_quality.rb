require 'award'

def update_quality(awards)
  awards.each do |award|
    case award.name
      when 'Blue Compare'
        award.quality += 1 if award.quality < 50
        award.quality += 1 if award.expires_in < 11 && award.quality < 50
        award.quality += 1 if award.expires_in < 6 && award.quality < 50
        award.expires_in -= 1
        award.quality = award.quality - award.quality if award.expires_in < 0
      when 'Blue Distinction Plus'
      when 'Blue First'
        award.quality += 1 if award.quality < 50
        award.expires_in -= 1
        award.quality += 1 if award.expires_in < 0 && award.quality < 50
      when 'Blue Star'
        award.quality -= 2 if award.expires_in > 0 && award.quality.between?(1,50)
        award.quality -= 4 if (award.expires_in == 0 || award.expires_in < 0) && award.quality.between?(4,50)        
        award.expires_in -= 1
      else
        award.quality -= 1 if award.expires_in > 0 && award.quality.between?(1,50)
        award.quality -= 2 if (award.expires_in == 0 || award.expires_in < 0) && award.quality < 50
        award.expires_in -= 1
    end
  end
end