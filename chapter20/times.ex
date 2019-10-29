defmodule Times do
	defmacro times_n(n) do
		quote do
			def unquote(:"times_#{n}")(n) do
				unquote(n) * n
			end
		end
	end
end

defmodule Test do
	require Times
	Times.times_n(3)
	Times.times_n(4)
end

IO.puts(Test.times_3(4))
IO.puts(Test.times_4(5))
