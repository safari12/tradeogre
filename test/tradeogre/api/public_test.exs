defmodule Tradeogre.API.PublicTest do
  use ExUnit.Case

  import Tesla.Mock

  alias Tradeogre.API

  @sample_response %Tesla.Env{status: 200, body: "hello"}
  @sample_market "btc-xmr"

  @base_url API.Config.base_url()
  @list_markets_url @base_url <> "/markets"
  @order_book_url @base_url <> "/orders/" <> @sample_market

  setup do
    mock fn
      %{method: :get, url: @list_markets_url} ->
        @sample_response
      %{method: :get, url: @order_book_url} ->
        @sample_response
    end

    :ok
  end

  test "list markets endpoint" do
    assert {:ok, %Tesla.Env{} = env} = API.Public.list_markets
    assert env == @sample_response
  end

  test "order book endpoint" do
    assert {:ok, %Tesla.Env{} = env} = API.Public.order_book(@sample_market)
    assert env == @sample_response
  end
end
