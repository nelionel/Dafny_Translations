function is_prime(n: int): bool
  requires n >= 0
{
  if n < 2 then false
  else if n == 2 then true
  else if n % 2 == 0 then false
  else is_prime_helper(n, 3)
}

function is_prime_helper(n: int, i: int): bool
  requires n >= 3
  requires i >= 3 && i % 2 == 1
  decreases if i * i <= n then n - i else 0
{
  if i * i > n then true
  else if n % i == 0 then false
  else is_prime_helper(n, i + 2)
}

method intersection(start1: int, end1: int, start2: int, end2: int) returns (result: string)
  requires start1 <= end1
  requires start2 <= end2
  ensures result == "YES" || result == "NO"
{
  // Find the intersection bounds
  var intersection_start := if start1 > start2 then start1 else start2;
  var intersection_end := if end1 < end2 then end1 else end2;
  
  // Check if there's actually an intersection
  if intersection_start > intersection_end {
    result := "NO";
  } else {
    // Calculate the length of the intersection
    // Since intervals are closed, length = end - start + 1
    var intersection_length := intersection_end - intersection_start + 1;
    
    // Check if the length is prime
    if is_prime(intersection_length) {
      result := "YES";
    } else {
      result := "NO";
    }
  }
}