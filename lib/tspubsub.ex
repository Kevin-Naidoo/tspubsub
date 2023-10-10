defmodule Tspubsub do
  alias Pubregistry
  @moduledoc """
  Documentation for `Tspubsub`.
  """
  use GenServer


  def init(subscriber) do
    {:ok, %{topic: :erlang , subscriber: subscriber}}
  end

  def start_link(subscriber) do
    GenServer.start_link(__MODULE__, name: spec_proc(subscriber))
  end

  def subscribe(subscriber, topic) do
    GenServer.cast(__MODULE__, {:subscribe, %{topic: topic, subscriber: spec_proc(subscriber)}})
  end

  def handle_cast({:subscribe, %{topic: topic, subscriber: subscriber}}, state) do
    subscribers = get_subscribers(topic, state)
    IO.puts("#{topic} & #{subscriber}")
    new_state = Map.put(state, topic, [subscriber | subscribers])
    {:noreply, new_state}
  end

  def get_subscribers(topic, state) do
    Map.get(state, topic, [])
  end

  def get_topics(state) do
    Map.keys(state)
  end

  def spec_proc(subscriber) do
    {:via, Registry, {Pubregistry, subscriber}}
  end

  def topics() do
    GenServer.call(__MODULE__, {:topics})
  end

  def handle_call({:topics}, _from, state) do
    {:reply, get_topics(state), state}
  end

end

defmodule NodePubsub do
  def start(client_name) do
    spawn(fn -> loop(client_name) end)
  end

  def loop(name) do
    receive do
      message ->
        IO.puts "#{name} received `#{message}`"
        loop(name)
    end
  end
end
