defmodule Tradeogre.API.Public do
  use Tesla

  alias Tradeogre.API.Config

  plug Tesla.Middleware.BaseUrl, Config.base_url()
  plug Tesla.Middleware.JSON, decode_content_types: Config.json_decode_content_types()
  plug Tesla.Middleware.Retry, delay: 500, max_retries: 3

  def list_markets, do: "/markets" |> get
  def order_book(market), do: "/orders/#{market}" |> get
  def trade_history(market), do: "/history/#{market}" |> get
  def ticker(market), do: "/ticker/#{market}" |> get
end
