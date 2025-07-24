method sum_squares(lst: seq<int>) returns (result: int)
  ensures result == sum_transformed_elements(lst)
{
  if |lst| == 0 {
    return 0;
  }
  
  var total := 0;
  var i := 0;
  
  while i < |lst|
    invariant 0 <= i <= |lst|
    invariant total == sum_partial_transformed_elements(lst, i)
    decreases |lst| - i
  {
    var value := lst[i];
    if i % 3 == 0 {
      total := total + value * value;
    } else if i % 4 == 0 {
      total := total + value * value * value;
    } else {
      total := total + value;
    }
    i := i + 1;
  }
  
  result := total;
}

function sum_transformed_elements(lst: seq<int>): int
{
  sum_partial_transformed_elements(lst, |lst|)
}

function sum_partial_transformed_elements(lst: seq<int>, up_to_index: int): int
  requires 0 <= up_to_index <= |lst|
  decreases up_to_index
{
  if up_to_index == 0 then 0
  else 
    var i := up_to_index - 1;
    var value := lst[i];
    var transformed_value := 
      if i % 3 == 0 then value * value
      else if i % 4 == 0 then value * value * value
      else value;
    sum_partial_transformed_elements(lst, i) + transformed_value
}