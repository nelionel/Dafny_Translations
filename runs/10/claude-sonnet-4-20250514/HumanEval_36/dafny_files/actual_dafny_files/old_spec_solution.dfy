function CountSevens(num: int): int
  requires num >= 0
  decreases num
{
  if num == 0 then 0
  else (if num % 10 == 7 then 1 else 0) + CountSevens(num / 10)
}

method fizz_buzz(n: int) returns (count: int)
  requires n >= 1
  ensures count >= 0
{
  count := 0;
  var i := 1;
  while i < n
    invariant 1 <= i <= n
    invariant count >= 0
    decreases n - i
  {
    if i % 11 == 0 || i % 13 == 0 {
      count := count + CountSevens(i);
    }
    i := i + 1;
  }
}