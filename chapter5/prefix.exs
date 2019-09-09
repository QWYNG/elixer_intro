prefix = fn
  first_name ->
    fn
      last_name -> "#{first_name} #{last_name}"
    end
end

IO.puts prefix.("Osawa").("Hiroaki")

