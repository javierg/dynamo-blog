defmodule CouchdbAdapter do
  use HTTPotion.Base

  def process_url(route) do
    :string.concat 'http://localhost:5984/ab/', route
  end

  def process_response_body(body) do
    json = :jsx.decode to_binary(body)
    json2 = Enum.map json, fn ({k, v}) -> { binary_to_atom(k), v } end
    :orddict.from_list json2
  end

end
