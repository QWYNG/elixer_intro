fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, _, c -> c
end

IO.puts fizz_buzz.(0, 0, 3)
IO.puts fizz_buzz.(0, 2, 3)
IO.puts fizz_buzz.(1, 2, 3)
IO.puts "------------------------------"

rem_fizz = fn n -> fizz_buzz.(rem(n, 3), rem(n, 5), n) end

IO.puts rem_fizz.(10)
IO.puts rem_fizz.(11)
IO.puts rem_fizz.(12)
IO.puts rem_fizz.(13)
IO.puts rem_fizz.(14)
IO.puts rem_fizz.(15)
IO.puts rem_fizz.(16)
