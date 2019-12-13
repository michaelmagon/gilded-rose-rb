class GildedRose
  BRIE = "Aged Brie"
  BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"
  CONJURED = "Conjured Mana Cake"
  NORMAL_DECREMENT = 1
  CONJURED_DECREMENT = NORMAL_DECREMENT*2

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      unless item.name == SULFURAS
        sell_by_decrement(item)
        case item.name
        when BRIE
          quality_increment(item)
          if item.sell_in < 0
            quality_increment(item)
          end
        when BACKSTAGE_PASS
          quality_increment(item)
          if item.sell_in < 11
            quality_increment(item)
          end
          if item.sell_in < 6
            quality_increment(item)
          end
          if item.sell_in < 0
            item.quality -= item.quality
          end
        when CONJURED
          decement_expired(item, CONJURED_DECREMENT)
        else
          decement_expired(item, NORMAL_DECREMENT)
        end
      end

    end
  end

  def quality_increment(item)
    item.quality += 1 if item.quality < 50
  end

  def quality_decrement(item, amount)
    amount.times{ item.quality -= 1 if item.quality > 0 }
  end

  def sell_by_decrement(item) 
    item.sell_in -= 1
  end

  def decement_expired(item, decement)
    item.sell_in < 0 ? quality_decrement(item,decement*2) : quality_decrement(item,decement)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
