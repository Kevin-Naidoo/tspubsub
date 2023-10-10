defmodule Pubregistry do
  def start_link do
    :global.register_name(Pubregistry, self())
    Registry.start_link(keys: :unique, name: Pubregistry)
  end
end
