defmodule Tradeogre do
  @behaviour CryptoExchange

  alias CryptoExchange.Pair
  alias Tradeogre.API

  def get_all_tickers do
    API.Public.list_markets
    |> API.Response.format_tickers_map
  end

  def get_ticker(%Pair{} = pair) do
    pair
    |> Pair.to_string
    |> API.Public.ticker
    |> API.Response.format_ticker
  end

  def get_order_book(%Pair{} = pair) do
    pair
    |> Pair.to_string
    |> API.Public.order_book
    |> API.Response.format_order_book
  end
end
