defmodule Practice.Palindrome do
  def palindrome(x) do
    pal = String.reverse(x)
    pal == x
  end
end
