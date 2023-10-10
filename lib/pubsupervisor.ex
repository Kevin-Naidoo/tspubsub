# defmodule Pubsupervisor do
#   use Supervisor
#     #Exercise 1: Implementing a Supervisor for BankAccount
#     def start_link(_) do
#       Supervisor.start_link(__MODULE__, :ok, name: :pub_supervisor)
#     end

#     def init(:ok) do
#       children = [
#         {BankAccount, 1000} # Example child specification
#       ]
#       Supervisor.init(children, strategy: :one_for_one)
#     end
# end
