method rounded_avg(n: int, m: int) returns (result: string)
  requires n > 0 && m > 0
  ensures n > m ==> result == "-1"
  ensures n <= m ==> |result| >= 3 && result[0..2] == "0b"
  ensures n <= m ==> 
    var sum := (m - n + 1) * (n + m) / 2;
    var count := m - n + 1;
    var avg := sum as real / count as real;
    var rounded := if (avg - (sum / count) as real) == 0.5 && (sum / count) % 2 == 0 
                   then sum / count  // round half to even (down)
                   else if (avg - (sum / count) as real) == 0.5 && (sum / count) % 2 == 1
                   then sum / count + 1  // round half to even (up)
                   else if avg - (sum / count) as real < 0.5
                   then sum / count  // round down
                   else sum / count + 1;  // round up
    result == IntToBinary(rounded)
{
  if n > m {
    return "-1";
  }
  
  // Calculate sum of integers from n to m using arithmetic series formula
  var sum := (m - n + 1) * (n + m) / 2;
  var count := m - n + 1;
  
  // Calculate rounded average using Python's banker's rounding (round half to even)
  var quotient := sum / count;
  var remainder := sum % count;
  var rounded := if remainder * 2 < count then quotient
                 else if remainder * 2 > count then quotient + 1
                 else if quotient % 2 == 0 then quotient  // even, round down
                 else quotient + 1;  // odd, round up
  
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