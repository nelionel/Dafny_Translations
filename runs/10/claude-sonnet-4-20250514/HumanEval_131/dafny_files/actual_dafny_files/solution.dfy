method digits(n: int) returns (result: int)
  requires n > 0
  ensures result >= 0
  ensures result == 0 <==> forall d :: d in DigitsOf(n) ==> d % 2 == 0
  ensures result > 0 <==> exists d :: d in DigitsOf(n) && d % 2 == 1
  ensures result > 0 ==> result == ProductOfOddDigits(n)
{
  var temp_n := n;
  var product := 1;
  var has_odd_digit := false;
  
  while temp_n > 0
    invariant temp_n >= 0
    invariant product >= 1
    invariant has_odd_digit ==> product > 1
    decreases temp_n
  {
    var digit := temp_n % 10;
    temp_n := temp_n / 10;
    
    if digit % 2 == 1 {
      product := product * digit;
      has_odd_digit := true;
    }
  }
  
  if has_odd_digit {
    result := product;
  } else {
    result := 0;
  }
}

function DigitsOf(n: int): set<int>
  requires n > 0
{
  if n < 10 then {n}
  else {n % 10} + DigitsOf(n / 10)
}

function ProductOfOddDigits(n: int): int
  requires n > 0
{
  if n < 10 then
    if n % 2 == 1 then n else 1
  else
    var digit := n % 10;
    var rest_product := ProductOfOddDigits(n / 10);
    if digit % 2 == 1 then digit * rest_product else rest_product
}