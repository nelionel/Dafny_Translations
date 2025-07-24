function CountSevens(num: int): int
  requires num >= 0
  decreases num
{
  if num == 0 then 0
  else (if num % 10 == 7 then 1 else 0) + CountSevens(num / 10)
}

function CountSevensInRange(n: int): int
  decreases if n <= 1 then 0 else n
{
  if n <= 1 then 0
  else (if (n-1) % 11 == 0 || (n-1) % 13 == 0 then CountSevens(n-1) else 0) + CountSevensInRange(n-1)
}

method fizz_buzz(n: int) returns (count: int)
  ensures count >= 0
  ensures count == CountSevensInRange(n)
{
  count := 0;
  var i := 1;
  while i < n
    invariant 1 <= i <= n + 1
    invariant count >= 0
    invariant count == CountSevensInRange(i)
    decreases if n <= i then 0 else n - i
  {
    if i % 11 == 0 || i % 13 == 0 {
      count := count + CountSevens(i);
    }
    i := i + 1;
  }
}