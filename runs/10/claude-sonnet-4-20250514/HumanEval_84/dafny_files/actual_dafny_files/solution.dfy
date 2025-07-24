method solve(N: int) returns (result: string)
  requires 0 <= N <= 10000
  ensures |result| > 0
  ensures forall i :: 0 <= i < |result| ==> result[i] == '0' || result[i] == '1'
  ensures result == toBinary(sumOfDigits(N))
  ensures (sumOfDigits(N) == 0 ==> result == "0") && (sumOfDigits(N) > 0 ==> result[0] == '1')
{
  var digitSum := sumOfDigits(N);
  result := toBinary(digitSum);
}

function sumOfDigits(n: int): int
  requires n >= 0
  ensures sumOfDigits(n) >= 0
  ensures n == 0 ==> sumOfDigits(n) == 0
  ensures n > 0 ==> sumOfDigits(n) > 0
  decreases n
{
  if n == 0 then 0
  else (n % 10) + sumOfDigits(n / 10)
}

function toBinary(n: int): string
  requires n >= 0
  ensures |toBinary(n)| > 0
  ensures forall i :: 0 <= i < |toBinary(n)| ==> toBinary(n)[i] == '0' || toBinary(n)[i] == '1'
  ensures (n == 0 ==> toBinary(n) == "0") && (n > 0 ==> toBinary(n)[0] == '1')
  decreases n
{
  if n == 0 then "0"
  else if n == 1 then "1"
  else toBinary(n / 2) + (if n % 2 == 0 then "0" else "1")
}