method rounded_avg(n: int, m: int) returns (result: string)
  requires n > 0 && m > 0
  ensures n > m ==> result == "-1"
  ensures n <= m ==> |result| >= 3 && result[0..2] == "0b"
  ensures n <= m ==> 
    var sum := (m - n + 1) * (n + m) / 2;
    var count := m - n + 1;
    var rounded := (2 * sum + count) / (2 * count);
    result == IntToBinary(rounded)
{
  if n > m {
    return "-1";
  }
  
  // Calculate sum of integers from n to m using arithmetic series formula
  var sum := (m - n + 1) * (n + m) / 2;
  var count := m - n + 1;
  
  // Calculate rounded average
  // Using integer arithmetic: (2*sum + count) / (2*count) gives proper rounding
  var rounded := (2 * sum + count) / (2 * count);
  
  // Convert to binary string
  result := IntToBinary(rounded);
}

function IntToBinary(n: int): string
  requires n >= 0
  ensures |IntToBinary(n)| >= 3 && IntToBinary(n)[0..2] == "0b"
  decreases n
{
  "0b" + IntToBinaryHelper(n)
}

function IntToBinaryHelper(n: int): string
  requires n >= 0
  ensures |IntToBinaryHelper(n)| >= 1
  decreases n
{
  if n == 0 then "0"
  else if n == 1 then "1"
  else IntToBinaryHelper(n / 2) + if n % 2 == 0 then "0" else "1"
}