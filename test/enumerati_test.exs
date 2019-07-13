defmodule EnumeratiTest do
  use ExUnit.Case, async: true
  doctest Enumerati

  @rick_ross %Support.Person{first_name: "rick", last_name: "ross"}
  @rick_james %Support.Person{first_name: "rick", last_name: "james"}
  @lebron_james %Support.Person{first_name: "lebron", last_name: "james"}
  @charles_barkley %Support.Person{first_name: "charles", last_name: "barkley"}
  @people [@rick_ross, @charles_barkley, @lebron_james, @rick_james]

  describe ".filter" do
    test "returns all items when there are no filters" do
      assert Enumerati.filter(@people, []) == @people
    end

    test "can filter by struct properties" do
      filtered = Enumerati.filter(@people, last_name: "james")
      assert Enum.count(filtered) == 2
      assert Enum.member?(filtered, @rick_james) == true
      assert Enum.member?(filtered, @lebron_james) == true
    end

    test "combines multiple filters with 'and'" do
      assert Enumerati.filter(@people, first_name: "rick", last_name: "james") == [@rick_james]
    end
  end

  describe ".order" do
    test "returns items in ascending order of struct properties by default" do
      assert Enumerati.order(@people, [:last_name, :first_name]) == [
               @charles_barkley,
               @lebron_james,
               @rick_james,
               @rick_ross
             ]
    end
  end
end
