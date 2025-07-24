function factorial(n: int): int
  requires n >= 0
  decreases n
{
  if n <= 1 then 1 else n * factorial(n - 1)
}

function sumRange(n: int): int
  requires n >= 0
{
  n * (n + 1) / 2
}

method f(n: int) returns (result: seq<int>)
  requires n >= 0
  ensures |result| == n
  ensures forall i :: 0 <= i < n ==> 
    (if (i + 1) % 2 == 0 then result[i] == factorial(i + 1) 
     else result[i] == sumRange(i + 1))
{
  result := [];
  
  var i := 1;
  while i <= n
    invariant 1 <= i <= n + 1
    invariant |result| == i - 1
    invariant forall j :: 0 <= j < |result| ==> 
      (if (j + 1) % 2 == 0 then result[j] == factorial(j + 1) 
       else result[j] == sumRange(j + 1))
    decreases n + 1 - i
  {
    if i % 2 == 0 {
      result := result + [factorial(i)];
    } else {
      result := result + [sumRange(i)];
    }
    i := i + 1;
  }
}