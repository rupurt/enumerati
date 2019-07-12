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
end
