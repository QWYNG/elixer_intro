defmodule SpawnToken do
  def run do
    pid1 = spawn(SpawnToken, :process, [])
    pid2 = spawn(SpawnToken, :process, [])


    send(pid1, {self(), "Rakan" })
    send(pid2, {self(), "Thresh" })



    receive do
      token -> IO.puts(token)
      run
    end
  end

  def process do
    receive do
      {sender, token} -> send(sender, token)
    end
  end
end
