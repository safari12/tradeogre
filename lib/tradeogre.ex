defmodule Tradeogre do
  @behaviour CryptoExchange

  alias Tradeogre.API

  def get_all_tickers() do
    {:ok, result} = API.Public.list_markets
    API.Response.map_tickers(result)
  end

  def get_ticker(_pair) do
    [1]
  end
end
