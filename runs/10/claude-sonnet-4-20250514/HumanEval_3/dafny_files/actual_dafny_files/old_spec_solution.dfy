method below_zero(operations: seq<int>) returns (result: bool)
{
  var balance := 0;
  var i := 0;
  
  while i < |operations|
    invariant 0 <= i <= |operations|
    invariant balance == sum_up_to(operations, i)
    decreases |operations| - i
  {
    balance := balance + operations[i];
    if balance < 0 {
      return true;
    }
    i := i + 1;
  }
  
  return false;
}

function sum_up_to(operations: seq<int>, index: int): int
  requires 0 <= index <= |operations|
  decreases index
{
  if index == 0 then 0
  else sum_up_to(operations, index - 1) + operations[index - 1]
}