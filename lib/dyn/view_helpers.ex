defmodule ViewHelpers do
  def link_to path, label, class // "" do
    "<a href='" <> path <> "' class='" <> class <> "'>" <> label <> "</a>"
  end
end
