defmodule Enumerati do
  @moduledoc """
  Filter and order an enumerable collection of structs
  """

  @type attr_name :: atom
  @type attr_value :: term
  @type filters :: [{attr_name, attr_value | [attr_value]}]

  @spec filter([struct], filters) :: [struct]
  def filter(items, filters) do
    items
    |> Enum.filter(fn item ->
      filters
      |> Enum.map(&match_attr(&1, item))
      |> Enum.all?()
    end)
  end

  @spec order([struct], [attr_name]) :: [struct]
  def order(items, sort_by) do
    sort_by
    |> Enum.reverse()
    |> Enum.reduce(
      items,
      fn s, acc ->
        acc
        |> Enum.sort(fn a, b ->
          av = Map.get(a, s)
          bv = Map.get(b, s)
          lte(av, bv)
        end)
      end
    )
  end

  defp match_attr({attr, matches}, item) when is_list(matches) do
    matches
    |> Enum.map(fn match -> Map.fetch!(item, attr) == match end)
    |> Enum.any?()
  end

  defp match_attr({attr, match}, item) do
    Map.fetch!(item, attr) == match
  end

  defp lte(%Decimal{} = av, %Decimal{} = bv), do: Decimal.cmp(av, bv) != :gt
  defp lte(av, bv), do: av <= bv
end
