method double_the_difference(lst: seq<real>) returns (result: int)
  ensures result >= 0
  ensures result == SumOfSquaresOfOddPositiveIntegers(lst)
{
  if |lst| == 0 {
    return 0;
  }
  
  var total := 0;
  var i := 0;
  
  while i < |lst|
    invariant 0 <= i <= |lst|
    invariant total >= 0
    invariant total == SumOfSquaresOfOddPositiveIntegers(lst[..i])
    decreases |lst| - i
  {
    var num := lst[i];
    
    // Check if the number is a positive integer and odd
    if IsPositiveInteger(num) {
      var intNum := RealToInt(num);
      if intNum % 2 == 1 {
        total := total + intNum * intNum;
      }
    }
    
    i := i + 1;
  }
  
  return total;
}

// Helper function to compute sum of squares of odd positive integers in sequence
function SumOfSquaresOfOddPositiveIntegers(lst: seq<real>): int
{
  if |lst| == 0 then 0
  else 
    var first := lst[0];
    var rest := SumOfSquaresOfOddPositiveIntegers(lst[1..]);
    if IsPositiveInteger(first) then
      var intFirst := RealToInt(first);
      if intFirst % 2 == 1 then
        intFirst * intFirst + rest
      else
        rest
    else
      rest
}

// Helper predicate to check if a real number is a positive integer
predicate IsPositiveInteger(x: real)
{
  x > 0.0 && x == RealToInt(x) as real
}

// Helper function to convert a real to int (assuming it's already an integer)
function RealToInt(x: real): int
  requires x == (x as int) as real
{
  x as int
}