defmodule Enumerati.SortedListTest do
  use ExUnit.Case, async: true

  describe ".new/1" do
    test "returns a struct with the list and it's count" do
      sorted_list = Enumerati.SortedList.new([:a])

      assert sorted_list.list == [:a]
      assert sorted_list.count == 1
    end
  end

  describe ".count/0" do
    test "returns the number of elements in the list" do
      sorted_list = Enumerati.SortedList.new([:a])

      assert Enum.count(sorted_list) == 1
    end
  end

  describe ".put/ " do
    test "foo" do
    end
  end
end
