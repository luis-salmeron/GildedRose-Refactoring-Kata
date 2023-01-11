defmodule GildedRoseTest do
  use ExUnit.Case

  describe "quality" do
    test "quality degrades by one" do
      item = common_item(quality: 20)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 19
    end

    test "quality degrades by two after sell by date" do
      item = common_item(sell_in: -5, quality: 20)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 18
    end

    test "quality never becomes negative" do
      item = common_item(quality: 0)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 0
    end

    test "quality never becomes more than 50" do
      item = aged_brie(quality: 50)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 50
    end
  end

  defp common_item(options) do
    %Item{
      name: Keyword.get(options, :name, "Common Item"),
      sell_in: Keyword.get(options, :sell_in, 10),
      quality: Keyword.get(options, :quality, 20)
    }
  end

  defp aged_brie(options) do
    common_item(Keyword.put(options, :name, "Aged Brie"))
  end
end
