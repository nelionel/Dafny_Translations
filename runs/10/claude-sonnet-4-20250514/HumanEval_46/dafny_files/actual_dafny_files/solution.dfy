method fib4(n: int) returns (result: int)
  requires n >= 0
  ensures result == fib4_spec(n)
{
  if n == 0 {
    return 0;
  } else if n == 1 {
    return 0;
  } else if n == 2 {
    return 2;
  } else if n == 3 {
    return 0;
  }
  
  var a, b, c, d := 0, 0, 2, 0;  // fib4(0), fib4(1), fib4(2), fib4(3)
  var i := 4;
  
  while i <= n
    invariant 4 <= i <= n + 1
    invariant a == fib4_spec(i-4)
    invariant b == fib4_spec(i-3)
    invariant c == fib4_spec(i-2)
    invariant d == fib4_spec(i-1)
    decreases n + 1 - i
  {
    var next_val := a + b + c + d;
    a, b, c, d := b, c, d, next_val;
    i := i + 1;
  }
  
  return d;
}

function fib4_spec(n: int): int
  requires n >= 0
  decreases n
{
  if n == 0 then 0
  else if n == 1 then 0
  else if n == 2 then 2
  else if n == 3 then 0
  else fib4_spec(n-1) + fib4_spec(n-2) + fib4_spec(n-3) + fib4_spec(n-4)
}