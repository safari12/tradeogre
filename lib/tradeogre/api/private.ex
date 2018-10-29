defmodule Tradeogre.API.Private do
  use Tesla

  alias Tradeogre.API.Config

  plug Tesla.Middleware.BaseUrl, Config.base_url
  plug Tesla.Middleware.Headers, [Config.auth_header()]
  plug Tesla.Middleware.JSON, decode_content_types: Config.json_decode_content_types()

  def submit_buy_order(market, quantity, price) do
    order_json(market, quantity, price)
    |> (&post("/order/buy", &1)).()
  end

  def submit_sell_order(market, quantity, price) do
    order_json(market, quantity, price)
    |> (&post("/order/sell", &1)).()
  end

  def cancel_order(uuid) do
    %{uuid: uuid}
    |> (&post("/order/cancel", &1)).()
  end

  def get_orders(market) do
    %{market: market}
    |> (&post("/account/orders", &1)).()
  end

  def get_order(uuid), do: "/account/order/#{uuid}" |> get

  def get_balance(currency) do
    %{currency: currency}
    |> (&post("/account/balance", &1)).()
  end

  def get_balances, do: "/account/balances" |> get

  defp order_json(market, quantity, price) do
    %{
      market: market,
      quantity: quantity,
      price: price
    }
  end
end
