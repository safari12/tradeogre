defmodule Tradeogre.API.Config do
  use CryptoExchange.API.Config, exchange: :tradeogre

  def json_decode_content_types do
    [
      "text/html"
    ]
  end

  def auth_header do
    {"authorization", token()}
  end

  def content_type_header do
    {"content_type_header"}
  end
end
