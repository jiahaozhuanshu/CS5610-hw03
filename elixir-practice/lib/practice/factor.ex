defmodule Practice.Factor do
# Attribution: https://stackoverflow.com/questions/28587249/how-can-this-code-be-better-structured-in-elixir
  def factor(n) do
    factors(n, div(n, 2)) |> Enum.filter(&is_prime?/1)
  end

  def factors(1, _), do: [1]
  def factors(_, 1), do: [1]
  def factors(n, i) do
    if rem(n, i) == 0 do
      [i|factors(n, i-1)]
    else
      factors(n, i-1)
    end
  end

  def is_prime?(n) do
    factors(n, div(n, 2)) == [1]
  end
end
