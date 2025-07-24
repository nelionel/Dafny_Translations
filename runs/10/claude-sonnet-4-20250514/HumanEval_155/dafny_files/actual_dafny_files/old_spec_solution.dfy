method even_odd_count(num: int) returns (result: seq<int>)
  ensures |result| == 2
  ensures result[0] >= 0 && result[1] >= 0
  ensures result[0] + result[1] == |digits_of(if num >= 0 then num else -num)|
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
    invariant forall j :: 0 <= j < i ==> (digit_seq[j] % 2 == 0 ==> even_count >= count_evens_up_to(digit_seq, j))
    invariant forall j :: 0 <= j < i ==> (digit_seq[j] % 2 == 1 ==> odd_count >= count_odds_up_to(digit_seq, j))
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

function count_evens_up_to(digits: seq<int>, index: int): int
  requires 0 <= index < |digits|
  decreases index
{
  if index == 0 then
    if digits[0] % 2 == 0 then 1 else 0
  else
    count_evens_up_to(digits, index - 1) + (if digits[index] % 2 == 0 then 1 else 0)
}

function count_odds_up_to(digits: seq<int>, index: int): int
  requires 0 <= index < |digits|
  decreases index
{
  if index == 0 then
    if digits[0] % 2 == 1 then 1 else 0
  else
    count_odds_up_to(digits, index - 1) + (if digits[index] % 2 == 1 then 1 else 0)
}