defmodule EnumeratiTest do
  use ExUnit.Case, async: true
  doctest Enumerati

  @rick_ross %Support.Person{first_name: "rick", last_name: "ross"}
  @rick_james %Support.Person{first_name: "rick", last_name: "james"}
  @lebron_james %Support.Person{first_name: "lebron", last_name: "james"}
  @charles_barkley %Support.Person{first_name: "charles", last_name: "barkley"}
  @people [@rick_ross, @charles_barkley, @lebron_james, @rick_james]

  describe ".filter" do
    test "returns all items when empty" do
      assert Enumerati.filter(@people, []) == @people
    end

    test "by struct attributes" do
      filtered = Enumerati.filter(@people, last_name: "james")
      assert Enum.count(filtered) == 2
      assert Enum.member?(filtered, @rick_james) == true
      assert Enum.member?(filtered, @lebron_james) == true
    end

    test "matches multiple attribute filters with 'and'" do
      assert Enumerati.filter(@people, first_name: "rick", last_name: "james") == [@rick_james]
    end

    test "attributes that are lists match with 'or'" do
      results = Enumerati.filter(@people, first_name: ["lebron", "charles"])

      assert Enum.count(results) == 2
      assert Enum.member?(results, @lebron_james)
      assert Enum.member?(results, @charles_barkley)
    end
  end

  describe ".order" do
    @product_1 %Support.Product{name: "Product 1", price: Decimal.new("0.4668")}
    @product_2 %Support.Product{name: "Product 2", price: Decimal.new("-0.6142")}
    @product_3 %Support.Product{name: "Product 3", price: Decimal.new("0.6468")}
    @product_4 %Support.Product{name: "Product 4", price: Decimal.new("-0.7109")}
    @products [@product_1, @product_2, @product_3, @product_4]

    test "returns items in ascending order of struct attributes" do
      assert Enumerati.order(@people, [:last_name, :first_name]) == [
               @charles_barkley,
               @lebron_james,
               @rick_james,
               @rick_ross
             ]
    end

    test "can order each attributes ascending" do
      assert Enumerati.order(@people, [{:last_name, :asc}, {:first_name, :asc}]) == [
               @charles_barkley,
               @lebron_james,
               @rick_james,
               @rick_ross
             ]
    end

    test "can order each attributes descending" do
      assert Enumerati.order(@people, [{:last_name, :desc}, {:first_name, :desc}]) == [
               @rick_ross,
               @rick_james,
               @lebron_james,
               @charles_barkley
             ]
    end

    test "can order decimals ascending" do
      assert Enumerati.order(@products, [:price]) == [
               @product_4,
               @product_2,
               @product_1,
               @product_3
             ]
    end

    test "can order decimals descending" do
      assert Enumerati.order(@products, [{:price, :desc}]) == [
               @product_3,
               @product_1,
               @product_2,
               @product_4
             ]
    end
  end
end
