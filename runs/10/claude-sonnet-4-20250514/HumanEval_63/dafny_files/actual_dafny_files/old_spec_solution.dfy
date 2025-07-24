function fibfib_spec(n: int): int
  requires n >= 0
  decreases n
{
  if n == 0 then 0
  else if n == 1 then 0
  else if n == 2 then 1
  else fibfib_spec(n-1) + fibfib_spec(n-2) + fibfib_spec(n-3)
}

method fibfib(n: int) returns (result: int)
  requires n >= 0
  ensures result == fibfib_spec(n)
{
  if n == 0 {
    return 0;
  } else if n == 1 {
    return 0;
  } else if n == 2 {
    return 1;
  }
  
  var a, b, c := 0, 0, 1;  // fibfib(0), fibfib(1), fibfib(2)
  var i := 3;
  
  while i <= n
    invariant 3 <= i <= n + 1
    invariant a == fibfib_spec(i-3)
    invariant b == fibfib_spec(i-2)
    invariant c == fibfib_spec(i-1)
    decreases n - i
  {
    var next_val := a + b + c;
    a, b, c := b, c, next_val;
    i := i + 1;
  }
  
  return c;
}