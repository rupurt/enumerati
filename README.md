# Enumerati
[![Build Status](https://github.com/rupurt/enumerati/workflows/Test/badge.svg?branch=master)](https://github.com/rupurt/enumerati/actions?query=workflow%3ATest)
[![hex.pm version](https://img.shields.io/hexpm/v/enumerati.svg?style=flat)](https://hex.pm/packages/enumerati)

Filter and order an enumerable collection of structs

## Installation

```elixir
def deps do
  [{:enumerati, "~> 0.0.8"}]
end
```

## Usage

Filter

```elixir
defmodule Person do
  defstruct ~w(first_name last_name)a
end

rick_ross = %Person{first_name: "rick", last_name: "ross"}
rick_james = %Person{first_name: "rick", last_name: "james"}
lebron_james = %Person{first_name: "lebron", last_name: "james"}
charles_barkley = %Person{first_name: "charles", last_name: "barkley"}
people = [rick_ross, charles_barkley, lebron_james, rick_james]

# match and
and_matches = Enumerati.filter(people, [first_name: "lebron", last_name: "james"])
Enum.count(and_matches) == 1
Enum.member?(and_matches, lebron_james) == true

# match or
or_matches = Enumerati.filter(people, [first_name: ["lebron", "charles"]])
Enum.count(or_matches) == 2
Enum.member?(or_matches, lebron_james) == true
Enum.member?(or_matches, charles_barkley) == true
```

Order

```elixir
defmodule Product do
  defstruct ~w(name price)a
end

product_1 = %Support.Product{name: "Product 1", price: Decimal.new("0.4668")}
product_2 = %Support.Product{name: "Product 2", price: Decimal.new("-0.6142")}
product_3 = %Support.Product{name: "Product 3", price: Decimal.new("0.6468")}
product_4 = %Support.Product{name: "Product 4", price: Decimal.new("-0.7109")}
products = [product_1, product_2, product_3, product_4]

# ascending
Enumerati.order(products, [:price]) == [
 product_4,
 product_2,
 product_1,
 product_3
]

Enumerati.order(products, [{:price, :asc}]) == [
 product_4,
 product_2,
 product_1,
 product_3
]

# descending
Enumerati.order(products, [{:price, :desc}]) == [
 product_3
 product_1,
 product_2,
 product_4,
]
```
