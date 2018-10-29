defmodule Tradeogre.API.Private do
  use Tesla

  alias Tradeogre.API.Config

  plug Tesla.Middleware.BaseUrl, Config.base_url
  plug Tesla.Middleware.Headers, [Config.auth_header()]
  plug Tesla.Middleware.JSON,
    decode_content_types: Config.json_decode_content_types()

  def submit_buy_order(market, quantity, price) do
    %{
      market: market,
      quantity: quantity,
      price: price
    }
    |> (&post("/order/buy", &1)).()
  end
end
