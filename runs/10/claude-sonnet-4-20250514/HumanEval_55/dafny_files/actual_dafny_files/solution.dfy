function fibSpec(n: int): int
  requires n > 0
  decreases n
{
  if n == 1 || n == 2 then 1
  else fibSpec(n-1) + fibSpec(n-2)
}

method fib(n: int) returns (result: int)
  requires n > 0
  ensures result == fibSpec(n)
{
  if n == 1 || n == 2 {
    return 1;
  }
  
  var a := 1;
  var b := 1;
  var i := 3;
  
  while i <= n
    invariant 3 <= i <= n + 1
    invariant a == fibSpec(i-2)
    invariant b == fibSpec(i-1)
  {
    var temp := a + b;
    a := b;
    b := temp;
    i := i + 1;
  }
  
  return b;
}