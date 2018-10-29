defmodule Tradeogre.API.PrivateTest do
  use ExUnit.Case

  import Tesla.Mock

  alias Tradeogre.API

  @base_url API.Config.base_url()
  @submit_buy_order_url @base_url <> "/order/buy"

  @sample_order %{
    market: "BTC-XMR",
    quantity: 1000,
    price: 0.5
  }
  @encoded_sample_order @sample_order |> Jason.encode!

  setup do
    mock fn
      %{method: :post, url: @submit_buy_order_url, body: @encoded_sample_order} ->
        json("hello")
    end

    :ok
  end

  describe "verify endpoints" do
    test "submit buy order" do

      assert {:ok, _} = API.Private.submit_buy_order(
        @sample_order.market,
        @sample_order.quantity,
        @sample_order.price
      )
    end
  end
end
