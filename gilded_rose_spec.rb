require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq 'foo'
    end

    it 'item sulfuras does not change' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 10, 80)]
      rose = GildedRose.new(items)
      5.times{rose.update_quality()}
      expect(items[0].sell_in).to eq 10
      expect(items[0].quality).to eq 80
    end    

    it 'item Aged Brie quality does not decrement' do
      items = [Item.new('Aged Brie', 5, 12)]
      rose = GildedRose.new(items)
      8.times{rose.update_quality()}
      expect(items[0].quality).to be > 12
      expect(items[0].quality).to eq 23
    end 

    it 'item Backstage passes quality does not decrement before sell by date' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 14, 13)]
      rose = GildedRose.new(items)
      14.times{rose.update_quality()}
      expect(items[0].quality).to eq 44
    end 

    it 'item Backstage passes quality drops to zero after sell by date' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 12, 12)]
      rose = GildedRose.new(items)
      13.times{rose.update_quality()}
      expect(items[0].quality).to eq 0
      expect(items[0].sell_in).to eq -1
    end 

    it 'item Conjured Mana Cake quality drops twice  as fast' do
      items = [Item.new('Conjured Mana Cake', 6, 22)]
      rose = GildedRose.new(items)
      10.times{rose.update_quality()}
      expect(items[0].sell_in).to eq -4
      expect(items[0].quality).to eq 0
    end 

    it 'normal item quality drops once per day' do
      items = [Item.new('Elixir of the Mongoose', 6, 22)]
      rose = GildedRose.new(items)
      8.times{rose.update_quality()}
      expect(items[0].sell_in).to eq -2
      expect(items[0].quality).to eq 12
    end 

  end
end
