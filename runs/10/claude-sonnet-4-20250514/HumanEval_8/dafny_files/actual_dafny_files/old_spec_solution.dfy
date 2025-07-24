method sum_product(numbers: seq<int>) returns (result: seq<int>)
  ensures |result| == 2
  ensures |numbers| == 0 ==> result == [0, 1]
  ensures |numbers| > 0 ==> result[0] == sum_of_seq(numbers) && result[1] == product_of_seq(numbers)
{
  if |numbers| == 0 {
    result := [0, 1];
  } else {
    var total_sum := 0;
    var total_product := 1;
    var i := 0;
    
    while i < |numbers|
      invariant 0 <= i <= |numbers|
      invariant total_sum == sum_of_prefix(numbers, i)
      invariant total_product == product_of_prefix(numbers, i)
    {
      total_sum := total_sum + numbers[i];
      total_product := total_product * numbers[i];
      i := i + 1;
    }
    
    result := [total_sum, total_product];
  }
}

function sum_of_seq(s: seq<int>): int
{
  sum_of_prefix(s, |s|)
}

function product_of_seq(s: seq<int>): int
{
  product_of_prefix(s, |s|)
}

function sum_of_prefix(s: seq<int>, n: int): int
  requires 0 <= n <= |s|
  decreases n
{
  if n == 0 then 0
  else s[n-1] + sum_of_prefix(s, n-1)
}

function product_of_prefix(s: seq<int>, n: int): int
  requires 0 <= n <= |s|
  decreases n
{
  if n == 0 then 1
  else s[n-1] * product_of_prefix(s, n-1)
}