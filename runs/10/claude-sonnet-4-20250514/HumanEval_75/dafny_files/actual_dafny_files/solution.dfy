method is_multiply_prime(a: int) returns (result: bool)
  requires a >= 0 && a < 100
  ensures result <==> (exists p1: int, p2: int, p3: int :: 
    p1 >= 2 && p2 >= 2 && p3 >= 2 && 
    is_prime_number(p1) && is_prime_number(p2) && is_prime_number(p3) && 
    p1 * p2 * p3 == a)
{
  // Handle edge case - minimum product of 3 primes is 2*2*2 = 8
  if a < 8 {
    result := false;
    return;
  }
  
  var prime_factor_count := 0;
  var temp := a;
  
  // Count factors of 2
  while temp % 2 == 0
    invariant temp > 0
    invariant temp * power_of_2(prime_factor_count) == a || (temp == a && prime_factor_count == 0)
    decreases temp
  {
    prime_factor_count := prime_factor_count + 1;
    temp := temp / 2;
  }
  
  // Check odd prime factors starting from 3
  var i := 3;
  while i * i <= temp
    invariant i >= 3 && i % 2 == 1
    invariant temp > 0
    invariant prime_factor_count >= 0
    decreases temp - i + 1
  {
    while temp % i == 0
      invariant temp > 0
      invariant i >= 3
      decreases temp
    {
      prime_factor_count := prime_factor_count + 1;
      temp := temp / i;
    }
    i := i + 2;
  }
  
  // If temp > 1, then it's a remaining prime factor
  if temp > 1 {
    prime_factor_count := prime_factor_count + 1;
  }
  
  result := prime_factor_count == 3;
}

// Helper function to check if a number is prime
function is_prime_number(n: int): bool
  requires n >= 2
{
  if n == 2 then true
  else if n % 2 == 0 then false
  else is_prime_odd_helper(n, 3)
}

function is_prime_odd_helper(n: int, i: int): bool
  requires n >= 3 && n % 2 == 1
  requires i >= 3 && i % 2 == 1
  decreases n - i
{
  if i * i > n then true
  else if n % i == 0 then false
  else is_prime_odd_helper(n, i + 2)
}

// Helper function for loop invariant
function power_of_2(exp: int): int
  requires exp >= 0
  ensures power_of_2(exp) >= 1
  decreases exp
{
  if exp == 0 then 1
  else 2 * power_of_2(exp - 1)
}