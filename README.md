# Enumerati
[![CircleCI](https://circleci.com/gh/rupurt/enumerati.svg?style=svg)](https://circleci.com/gh/rupurt/enumerati)

Filter and order an enumerable collection of structs

## Installation

```elixir
def deps do
  [
    {:enumerati, "~> 0.0.4"}
  ]
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

filtered = Enumerati.filter(people, [last_name: "james"])

Enum.count(filtered) == 2
Enum.member?(filtered, rick_james) == true
Enum.member?(filtered, lebron_james) == true
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

Enumerati.order(products, [:price]) == [
 product_4,
 product_2,
 product_1,
 product_3
]
```
