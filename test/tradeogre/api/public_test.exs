defmodule Tradeogre.API.PublicTest do
  use ExUnit.Case

  import Tesla.Mock

  alias Tradeogre.API

  @sample_response %Tesla.Env{status: 200, body: "hello"}
  @sample_market "btc-xmr"

  @base_url API.Config.base_url()
  @list_markets_url @base_url <> "/markets"
  @order_book_url @base_url <> "/orders/" <> @sample_market
  @trade_history_url @base_url <> "/history/" <> @sample_market
  @ticker_url @base_url <> "/ticker/" <> @sample_market

  setup do
    mock fn
      %{method: :get, url: @list_markets_url} ->
        @sample_response
      %{method: :get, url: @order_book_url} ->
        @sample_response
      %{method: :get, url: @trade_history_url} ->
        @sample_response
      %{method: :get, url: @ticker_url} ->
        @sample_response
    end

    :ok
  end

  describe "verify endpoints" do
    test "list markets" do
      assert_sample_response(fn ->
        API.Public.list_markets
      end)
    end

    test "order book by market" do
      assert_sample_response(fn ->
        API.Public.order_book(@sample_market)
      end)
    end

    test "trade history by market" do
      assert_sample_response(fn ->
        API.Public.trade_history(@sample_market)
      end)
    end

    test "ticker by market" do
      assert_sample_response(fn ->
        API.Public.ticker(@sample_market)
      end)
    end
  end

  defp assert_sample_response(api_call) do
    assert {:ok, %Tesla.Env{} = env} = api_call.()
    assert env == @sample_response
  end
end
