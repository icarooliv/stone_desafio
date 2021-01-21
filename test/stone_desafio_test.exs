defmodule StoneDesafioTest do
  use ExUnit.Case
  doctest StoneDesafio

  @items [
    %StoneDesafio.Item{base_price: 20, name: "item_1", quantity: 2},
    %StoneDesafio.Item{base_price: 15, name: "item_2", quantity: 2},
    %StoneDesafio.Item{base_price: 30, name: "item_3", quantity: 1}
  ]
  @persons [
    "person1@email.com",
    "person2@email.com",
    "person3@email.com"
  ]

  test "split_order/2 distribute with even values" do
    assert StoneDesafio.split_order(@items, @persons) ==
             {:ok,
              %{
                "person1@email.com" => 34,
                "person2@email.com" => 33,
                "person3@email.com" => 33
              }}
  end

  test "split_order/2 distribute equally when division doesn't have remainder" do
    items = [%StoneDesafio.Item{base_price: 5, name: "item_4", quantity: 1} | @items]

    assert StoneDesafio.split_order(items, @persons) ==
             {:ok,
              %{
                "person1@email.com" => 35,
                "person2@email.com" => 35,
                "person3@email.com" => 35
              }}
  end

  test "split_order/2 distribute equally when persons list have duplicated emails" do
    persons = [
      "person1@email.com",
      "person2@email.com",
      "person2@email.com"
    ]

    assert StoneDesafio.split_order(@items, persons) ==
             {:ok,
              %{
                "person1@email.com" => 50,
                "person2@email.com" => 50
              }}
  end

  test "split_order/2 returns error message to empty items" do
    assert StoneDesafio.split_order([], @persons) ==
             {:error, "Empty items list"}
  end

  test "split_order/2 returns error message to empty persons" do
    assert StoneDesafio.split_order(@items, []) ==
             {:error, "Empty persons list"}
  end
end
