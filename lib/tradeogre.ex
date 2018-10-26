defmodule Tradeogre do
  @behaviour CryptoExchange

  alias CryptoExchange.Pair
  alias Tradeogre.API

  def get_all_tickers() do
    API.Public.list_markets
    |> API.Response.map_tickers
  end

  def get_order_book(%Pair{base: base, quote: q}) do
    API.Public.order_book("#{base}-#{q}")
    |> API.Response.map_order_book
  end
end
