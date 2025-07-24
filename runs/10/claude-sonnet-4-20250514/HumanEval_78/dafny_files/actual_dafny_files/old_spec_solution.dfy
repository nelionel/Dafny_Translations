method hex_key(num: string) returns (count: int)
  ensures count >= 0
  ensures count <= |num|
  ensures count == CountPrimeHexDigits(num, 0)
{
  count := 0;
  var i := 0;
  
  while i < |num|
    invariant 0 <= i <= |num|
    invariant count >= 0
    invariant count == CountPrimeHexDigits(num, i)
    decreases |num| - i
  {
    var digit := num[i];
    if digit == '2' || digit == '3' || digit == '5' || digit == '7' || digit == 'B' || digit == 'D' {
      count := count + 1;
    }
    i := i + 1;
  }
}

function CountPrimeHexDigits(s: string, upTo: int): int
  requires 0 <= upTo <= |s|
  decreases upTo
{
  if upTo == 0 then 0
  else 
    var digit := s[upTo - 1];
    var isPrime := digit == '2' || digit == '3' || digit == '5' || digit == '7' || digit == 'B' || digit == 'D';
    CountPrimeHexDigits(s, upTo - 1) + (if isPrime then 1 else 0)
}