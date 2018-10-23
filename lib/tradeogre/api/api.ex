defmodule Tradeogre.API do
  defmodule Public do
    use HTTPoison.Base

    alias Tradeogre.API.Config

    def process_url(url), do: Config.base_url <> url
    def process_response_body(body), do: body |> Poison.decode!

    def list_markets do
      get("/markets", [])
    end
  end
end
