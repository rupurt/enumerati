defmodule Enumerati.SortedList do
  alias __MODULE__

  defstruct ~w(list count)a

  def new(list) do
    %SortedList{
      list: list,
      count: Enum.count(list)
    }
  end
end

defimpl Enumerable, for: Enumerati.SortedList do
  def count(sorted_list) do
    {:ok, sorted_list.count}
  end

  def member?(sorted_list, element) do
    Enumerable.member?(sorted_list.list, element)
  end

  def reduce(sorted_list, acc, fun) do
    Enumerable.reduce(sorted_list.list, acc, fun)
  end

  def slice(sorted_list) do
    Enumerable.slice(sorted_list.list)
  end
end
