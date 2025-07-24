method even_odd_count(num: int) returns (result: seq<int>)
  ensures |result| == 2
  ensures result[0] >= 0 && result[1] >= 0
  ensures result[0] + result[1] == |digits_of(if num >= 0 then num else -num)|
  ensures result[0] == count_even_digits(if num >= 0 then num else -num)
  ensures result[1] == count_odd_digits(if num >= 0 then num else -num)
{
  var abs_num := if num >= 0 then num else -num;
  var digit_seq := digits_of(abs_num);
  
  var even_count := 0;
  var odd_count := 0;
  var i := 0;
  
  while i < |digit_seq|
    invariant 0 <= i <= |digit_seq|
    invariant even_count >= 0 && odd_count >= 0
    invariant even_count + odd_count == i
    invariant even_count == count_even_digits_in_seq(digit_seq[..i])
    invariant odd_count == count_odd_digits_in_seq(digit_seq[..i])
  {
    if digit_seq[i] % 2 == 0 {
      even_count := even_count + 1;
    } else {
      odd_count := odd_count + 1;
    }
    i := i + 1;
  }
  
  result := [even_count, odd_count];
}

function digits_of(n: int): seq<int>
  requires n >= 0
  decreases n
{
  if n < 10 then [n]
  else digits_of(n / 10) + [n % 10]
}

function count_even_digits(n: int): int
  requires n >= 0
{
  count_even_digits_in_seq(digits_of(n))
}

function count_odd_digits(n: int): int
  requires n >= 0
{
  count_odd_digits_in_seq(digits_of(n))
}

function count_even_digits_in_seq(digits: seq<int>): int
{
  if |digits| == 0 then 0
  else (if digits[0] % 2 == 0 then 1 else 0) + count_even_digits_in_seq(digits[1..])
}

function count_odd_digits_in_seq(digits: seq<int>): int
{
  if |digits| == 0 then 0
  else (if digits[0] % 2 == 1 then 1 else 0) + count_odd_digits_in_seq(digits[1..])
}