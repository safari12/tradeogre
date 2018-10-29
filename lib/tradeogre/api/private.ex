defmodule Tradeogre.API.Private do
  use Tesla

  alias Tradeogre.API.Config

  plug Tesla.Middleware.BaseUrl, Config.base_url
  plug Tesla.Middleware.Headers, [Config.auth_header()]
  plug Tesla.Middleware.JSON, decode_content_types: Config.json_decode_content_types()
  plug Tesla.Middleware.Retry, delay: 500, max_retries: 3

  def submit_buy_order(market, quantity, price) do
    order_json(market, quantity, price)
    |> (&post("/order/buy", &1)).()
  end

  def submit_sell_order(market, quantity, price) do
    order_json(market, quantity, price)
    |> (&post("/order/sell", &1)).()
  end

  defp order_json(market, quantity, price) do
    %{
      market: market,
      quantity: quantity,
      price: price
    }
  end
end
