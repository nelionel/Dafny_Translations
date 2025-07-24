function is_prime_func(n: int): bool
  requires n >= 0
{
  if n < 2 then false
  else if n == 2 then true
  else if n % 2 == 0 then false
  else check_odd_divisors(n, 3)
}

function check_odd_divisors(n: int, i: int): bool
  requires n >= 3 && i >= 3 && i % 2 == 1
  decreases n - i * i + 1
{
  if i * i > n then true
  else if n % i == 0 then false
  else check_odd_divisors(n, i + 2)
}

method prime_length(s: string) returns (result: bool)
  ensures result == is_prime_func(|s|)
{
  var length := |s|;
  result := is_prime_num(length);
}

method is_prime_num(n: int) returns (result: bool)
  requires n >= 0
  ensures result == is_prime_func(n)
{
  if n < 2 {
    result := false;
  } else if n == 2 {
    result := true;
  } else if n % 2 == 0 {
    result := false;
  } else {
    // Check odd divisors from 3 up to sqrt(n)
    var i := 3;
    result := true;
    while i * i <= n && result
      invariant 3 <= i && i % 2 == 1
      invariant result ==> (forall k :: 3 <= k < i && k % 2 == 1 ==> n % k != 0)
      invariant result == check_odd_divisors(n, i)
      decreases n - i * i + 1
    {
      if n % i == 0 {
        result := false;
      } else {
        i := i + 2;
      }
    }
  }
}