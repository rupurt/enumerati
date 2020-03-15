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

  @spec order([struct], [attr_name | {attr_name, :asc} | {attr_name, :desc}]) :: [struct]
  def order(items, sort_by) do
    sort_by
    |> Enum.reverse()
    |> Enum.reduce(
      items,
      fn
        {sort_attr, :desc}, items -> sort(items, sort_attr, &gte/2)
        {sort_attr, :asc}, items -> sort(items, sort_attr, &lte/2)
        sort_attr, items -> sort(items, sort_attr, &lte/2)
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

  defp sort(items, sort_attr, sort_func) do
    items
    |> Enum.sort(fn a, b ->
      sort_func.(
        Map.get(a, sort_attr),
        Map.get(b, sort_attr)
      )
    end)
  end

  defp lte(%Decimal{} = av, %Decimal{} = bv), do: Decimal.cmp(av, bv) != :gt
  defp lte(av, bv), do: av <= bv

  defp gte(%Decimal{} = av, %Decimal{} = bv), do: Decimal.cmp(av, bv) != :lt
  defp gte(av, bv), do: av >= bv
end
