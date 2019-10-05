defmodule Spawn1 do
  def great do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}"}
    end
  end
end

pid = spawn(Spawn1, :great, [])
send pid, {self(), "world!!"}

receive do
        {:ok, message} ->
          IO.puts message
        end
