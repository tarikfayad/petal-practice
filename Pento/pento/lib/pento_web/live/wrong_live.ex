defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:")}
  end

  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <br/>
    <h2>
      <%= for n <- 1..10 do %>
        <.link class="bg-blue-500 hover:bg-blue-700
        text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
        phx-click="guess" phx-value-number = {n} >
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end

  # Letting pattern matching do the heavy lifting. handle_event will only trigger for functions where the first argument is "guess".
  # The second property is accessing the map with a key of "number" from "phx-value-number" and assigning it to the variable guess.
  # The socket is passed in so that we can update the live view which we do via socket.assigns. We assigned score to it on line 5 as well as message.
  def handle_event("guess", %{"number" => guess}, socket) do
    message = " Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1
    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end
end
