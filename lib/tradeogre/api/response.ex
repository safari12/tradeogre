defmodule Tradeogre.API.Response do

  alias CryptoExchange.{Pair, Ticker, Order}

  def format_tickers_map({:ok, %{body: body}}) do
    body
    |> Enum.reduce(%{}, fn x, acc ->
      r = Enum.reduce(x, %{}, &update_ticker_map/2)
      Map.merge(acc, r)
    end)
  end

  def format_ticker({:ok, %{body: body}}) do
    body |> json_to_ticker
  end

  def format_order_book({:ok, %{body: body}}) do
    body |> json_to_order_book
  end

  @spec update_ticker_map(Map.t, Map.t) :: Map.t
  def update_ticker_map({k, v}, acc) do
    pair = Pair.from_string(k)
    ticker = json_to_ticker(v)
    Map.put(acc, pair, ticker)
  end

  @spec json_to_order_book(Map.t) :: Order.Book.t
  defp json_to_order_book(%{"buy" => json_bids, "sell" => json_asks}) do
    bids = json_bids
    |> Enum.map(&json_to_order/1)
    |> Enum.sort(&(&1.price >= &2.price))

    asks = json_asks
    |> Enum.map(&json_to_order/1)
    |> Enum.sort(&(&1.price <= &2.price))

    %Order.Book{
      bids: bids,
      asks: asks
    }
  end

  defp json_to_order({price, quantity}) do
    %Order{
      price: price |> String.to_float,
      quantity: quantity |> String.to_float
    }
  end

  @spec json_to_ticker(Map.t) :: Ticker.t
  defp json_to_ticker(json) do
    price = json["price"] |> String.to_float
    volume = json["volume"] |> String.to_float
    low = json["low"] |> String.to_float
    high = json["high"] |> String.to_float
    initial_price = json["initialprice"] |> String.to_float

    %Ticker{
      last_price: price,
      lowest_ask_price: low,
      highest_bid_price: high,
      percent_change: calculate_percent_change(price, initial_price),
      volume: volume,
      quote_volume: volume / price
    }
  end

  defp calculate_percent_change(new, initial) do
    (new - initial) / initial * 100
  end
end
