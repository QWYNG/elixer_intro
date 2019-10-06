defmodule Link3 do
  import :timer, only: [ sleep: 1 ]

  def sad_function do
    raise RuntimeError
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Link3, :sad_function, [])
    sleep 500
    receive do
      msg -> IO.puts("MESSAGE RECEIVED: #{inspect msg}")
      after 500 -> IO.puts("Nothing happened as far as I am concerned")
    end
  end
end

Link3.run

# 例外を履いたときに

#モニター
#MESSAGE RECEIVED: {:DOWN, #Reference<0.2910818851.99614724.161124>, :process, #PID<0.98.0>, {%RuntimeError{message: "runtime error"}, [{Link3, :sad_function, 0, [file: 'link3.exs', line: 5]}]}}

#リンク
# MESSAGE RECEIVED: {:EXIT, #PID<0.98.0>, {%RuntimeError{message: "runtime error"}, [{Link3, :sad_function, 0, [file: 'link3.exs', line: 5]}]}}

#exitかdownかで違う リンクは例外を捕まえない
