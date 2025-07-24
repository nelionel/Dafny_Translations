function power(base: int, exp: int): int
  requires exp >= 0
  decreases exp
{
  if exp == 0 then 1
  else base * power(base, exp - 1)
}

method starts_one_ends(n: int) returns (result: int)
  ensures n <= 0 ==> result == 0
  ensures n == 1 ==> result == 1
  ensures n == 2 ==> result == power(10, n - 1) + 9 * power(10, n - 2) - 1
  ensures n >= 3 ==> result == power(10, n - 1) + 9 * power(10, n - 2) - power(10, n - 2)
  ensures result >= 0
{
  if n <= 0 {
    result := 0;
    return;
  }
  
  if n == 1 {
    result := 1;  // Only the number "1"
    return;
  }
  
  // Numbers that start with 1: 1 followed by (n-1) digits
  // The remaining (n-1) digits can be anything from 0-9
  var starts_with_1 := power(10, n - 1);
  
  // Numbers that end with 1: (n-1) digits followed by 1
  // The first digit can be 1-9 (not 0, as we need n-digit numbers)
  // The remaining (n-2) digits can be anything from 0-9
  var ends_with_1 := 9 * power(10, n - 2);
  
  // Numbers that both start and end with 1: 1 followed by (n-2) digits followed by 1
  // The middle (n-2) digits can be anything from 0-9
  var starts_and_ends_with_1: int;
  if n == 2 {
    starts_and_ends_with_1 := 1;  // Only "11"
  } else {
    starts_and_ends_with_1 := power(10, n - 2);
  }
  
  // Apply inclusion-exclusion principle
  result := starts_with_1 + ends_with_1 - starts_and_ends_with_1;
}