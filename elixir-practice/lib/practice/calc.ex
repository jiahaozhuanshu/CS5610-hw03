defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

# Tell whether input is a operator or number
  def operator(token) do 
    if(token in ["+", "-", "/", "*"]) do 
       true
    else 
       false
    end
  end

# give ops ranks
  def op_order(token) do
    cond do
      token == "+" || token == "-"-> 10
      token == "*" || token == "/"-> 100
      true -> 0
    end
  end 

# discussed and worked with Rouni Yin
# calculate stacks based on operations
  def calculate([lst_hd|lst_tl], result_stack) do
     if (operator(lst_hd)) do 
        val1 = hd(result_stack)
        val2 = hd(tl(result_stack))
        rest = tl(tl(result_stack))    

        cond do 
            lst_hd == "+" -> calculate(lst_tl, [val2 + val1 | rest])
            lst_hd == "-" -> calculate(lst_tl, [val2 - val1 | rest])
            lst_hd == "*" -> calculate(lst_tl, [val2 * val1 | rest])
            lst_hd == "/" -> calculate(lst_tl, [val2 / val1 | rest])
        end
     else
        calculate(lst_tl, [parse_float(lst_hd)] ++ result_stack)
     end        
  end

  def calculate([], result) do 
     hd(result)
  end 
# infix to postfix function
# Worked with Rouni Yin
  def convert([expr_hd|expr_tl], postfix, op_stack) do
      if (operator(expr_hd)) do
      if (length(op_stack)== 0 || op_order(hd(op_stack)) < op_order(expr_hd)) do
	     convert(expr_tl, postfix, [expr_hd|op_stack])
	 else 
             convert([expr_hd|expr_tl], postfix ++ [hd(op_stack)], tl(op_stack))
         end
      else
          convert(expr_tl, postfix ++ [expr_hd], op_stack)

      end
  
          
  end


  def convert([], postfix, op_stack) do 
     if (length(op_stack) == 0) do
          postfix
     else 
         convert([], postfix ++ [hd(op_stack)], tl(op_stack))
     end 
  end 
 

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    calculate(convert(String.split(expr, ~r/\s+/), [], []), [])

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

 
end 
