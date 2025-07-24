method solve(N: int) returns (result: string)
  requires 0 <= N <= 10000
  ensures |result| > 0
{
  var digitSum := sumOfDigits(N);
  result := toBinary(digitSum);
}

function sumOfDigits(n: int): int
  requires n >= 0
  decreases n
{
  if n == 0 then 0
  else (n % 10) + sumOfDigits(n / 10)
}

function toBinary(n: int): string
  requires n >= 0
  decreases n
{
  if n == 0 then "0"
  else if n == 1 then "1"
  else toBinary(n / 2) + (if n % 2 == 0 then "0" else "1")
}