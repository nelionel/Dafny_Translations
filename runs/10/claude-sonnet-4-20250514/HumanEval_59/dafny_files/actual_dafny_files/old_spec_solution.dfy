method largest_prime_factor(n: int) returns (result: int)
  requires n > 1
  ensures result >= 1
{
  var largest_factor := 1;
  var current_n := n;
  
  // Check for factor 2
  while current_n % 2 == 0
    invariant current_n >= 1
    invariant largest_factor >= 1
    decreases current_n
  {
    largest_factor := 2;
    current_n := current_n / 2;
  }
  
  // Check for odd factors starting from 3
  var factor := 3;
  while factor * factor <= current_n
    invariant factor >= 3
    invariant factor % 2 == 1
    invariant current_n >= 1
    invariant largest_factor >= 1
    decreases current_n
  {
    while current_n % factor == 0
      invariant current_n >= 1
      invariant factor >= 3
      invariant largest_factor >= 1
      decreases current_n
    {
      largest_factor := factor;
      current_n := current_n / factor;
    }
    factor := factor + 2;
  }
  
  // If current_n is still greater than 1, then it's a prime factor
  if current_n > 1 {
    largest_factor := current_n;
  }
  
  result := largest_factor;
}