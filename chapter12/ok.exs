ok! = fn
  {:ok, data} -> data
  param -> raise "Failed something!!! #{inspect(param)}"
end

IO.inspect(ok!.(File.open("chapter12/Rakefile")))
IO.inspect(ok!.(File.open("not_exist!")))
