method digits(n: int) returns (result: int)
  requires n > 0
  ensures result >= 0
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