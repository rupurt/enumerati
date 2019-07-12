defmodule EnumeratiTest do
  use ExUnit.Case, async: true
  doctest Enumerati

  @rick %Support.Person{first_name: "rick", last_name: "james"}
  @lebron %Support.Person{first_name: "lebron", last_name: "james"}
  @charles %Support.Person{first_name: "charles", last_name: "barkley"}
  @people [@rick, @lebron, @charles]

  describe ".filter" do
    test "returns all items when there are no filters" do
      assert Enumerati.filter(@people, []) == @people
    end

    test "can filter by struct properties" do
      assert Enumerati.filter(@people, last_name: "james") == [@rick, @lebron]
    end

    test "combines multiple filters with 'and'" do
      assert Enumerati.filter(@people, first_name: "rick", last_name: "james") == [@rick]
    end
  end
end
