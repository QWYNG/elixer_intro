defmodule FileCat do
  import File, only: [ dir?: 1, read!: 1 ]
  
  def cat(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :count_cat, file_name, client } ->
        send client, { :answer, file_name, count_cat(file_name), self() }
        cat(scheduler)

      { :shutdowon } -> exit(:normal)
    end
  end

  defp count_cat(file_name) do
    if dir?(file_name) do
      0
    else
      Regex.scan(~r/cat/, read!(file_name))
      |> length
    end
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, {:count_cat, next, self}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.map(results, fn {_file_name, n} ->  n end)
          |> Enum.sum
        end

      {:answer, file_name, result, _pid} -> schedule_processes(processes, queue, [ {file_name, result} | results ])
    end
  end
end

File.cd('/home/qwyng/ピクチャ')
to_process = File.ls!('../ピクチャ')

Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run,
    [num_processes, FileCat, :cat, to_process]
  )
  # 最初は結果も表示
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n # time (s)"
  end
  :io.format "~2B ~.2f~n", [num_processes, time/1000000.0]
end
