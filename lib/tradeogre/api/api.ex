defmodule Tradeogre.API do
  defmodule Public do
    use HTTPoison.Base

    alias Tradeogre.API.Config

    def process_url(url), do: Config.base_url <> url
    def process_response_body(body), do: body |> Poison.decode!

    def list_markets, do: "/markets" |> get
    def order_book(market), do: "/orders/#{market}" |> get
    def trade_history(market), do: "/history/#{market}" |> get
  end
end
