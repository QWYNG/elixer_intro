defmodule Spawn2 do
  def great do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}"}
    end
  end
end

pid = spawn(Spawn2, :great, [])
send pid, {self(), "world!!"}

receive do
  {:ok, message} ->
    IO.puts message
end

send pid, {self(), "Kermit!"}
receive do
  {:ok, message} ->
  IO.puts message
  after 500 -> IO.puts "The greeter has gone away"
end
