defmodule StoneDesafio.Item do
  @moduledoc """
  Struct for Item.
  """
  defstruct [
    :name,
    :quantity,
    :base_price
  ]
end

defmodule StoneDesafio do
  @moduledoc """
  Documentation for `StoneDesafio`.
  """

  @doc """
  Get a list of items and persons and splits total value into given persons.
  """
  def split_order([], _), do: {:error, "Empty items list"}
  def split_order(_, []), do: {:error, "Empty persons list"}
  def split_order([], []), do: {:error, "Both lists empty"}

  def split_order(items, persons) do
    result =
      Enum.uniq(persons)
      |> Kernel.length()
      |> split_values(items)
      |> format_result(persons)

    {:ok, result}
  end

  defp split_values(persons_count, items) do
    {base_quota, remainder} =
      calculate_total_order(items)
      |> divrem(persons_count)

    List.duplicate(base_quota, persons_count)
    |> distribute_remainder(remainder)
  end

  defp distribute_remainder(list, rest, index \\ 0)

  defp distribute_remainder(list, 0, _) do
    list
  end

  defp distribute_remainder(list, rest, index) do
    value = Enum.at(list, index)

    List.replace_at(list, index, value + 1)
    |> distribute_remainder(rest - 1, index + 1)
  end

  defp calculate_total_order(items) do
    Enum.reduce(items, 0, fn item, total ->
      total + item.quantity * item.base_price
    end)
  end

  defp format_result(splitted_values, persons) do
    Enum.zip(persons, splitted_values)
    |> Enum.into(%{})
  end

  defp divrem(dividend, divisor) do
    {div(dividend, divisor), rem(dividend, divisor)}
  end
end
