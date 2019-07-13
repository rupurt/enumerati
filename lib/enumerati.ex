defmodule Enumerati do
  @moduledoc """
  Filter and order an enumerable collection of structs
  """

  @spec filter([struct], list) :: [struct]
  def filter(items, filters) do
    items
    |> Enum.filter(fn item ->
      filters
      |> Enum.map(fn {k, v} -> Map.fetch!(item, k) == v end)
      |> Enum.all?()
    end)
  end

  @spec order([struct], list) :: [struct]
  def order(items, sort_by) do
    sort_by
    |> Enum.reverse()
    |> Enum.reduce(
      items,
      fn s, acc -> acc |> Enum.sort(&(Map.get(&1, s) <= Map.get(&2, s))) end
    )
  end
end
