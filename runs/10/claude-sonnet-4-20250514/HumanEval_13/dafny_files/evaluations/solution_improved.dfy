method greatest_common_divisor(a: int, b: int) returns (result: int)
  ensures result >= 0
  ensures (a == 0 && b == 0) ==> result == 0
  ensures (a != 0 || b != 0) ==> result > 0
  ensures var abs_a := if a >= 0 then a else -a;
          var abs_b := if b >= 0 then b else -b;
          (abs_a == 0 || abs_a % result == 0) && (abs_b == 0 || abs_b % result == 0)
  ensures var abs_a := if a >= 0 then a else -a;
          var abs_b := if b >= 0 then b else -b;
          forall d: int :: d > 0 && 
            ((abs_a == 0 || abs_a % d == 0) && (abs_b == 0 || abs_b % d == 0)) ==> d <= result
{
  var abs_a := if a >= 0 then a else -a;
  var abs_b := if b >= 0 then b else -b;
  
  var x := abs_a;
  var y := abs_b;
  
  while y != 0
    invariant x >= 0 && y >= 0
    invariant var orig_abs_a := if a >= 0 then a else -a;
              var orig_abs_b := if b >= 0 then b else -b;
              // GCD is preserved: gcd(x,y) = gcd(orig_abs_a, orig_abs_b)
              forall d: int :: d > 0 ==> 
                ((x == 0 || x % d == 0) && (y == 0 || y % d == 0)) <==> 
                ((orig_abs_a == 0 || orig_abs_a % d == 0) && (orig_abs_b == 0 || orig_abs_b % d == 0))
    decreases y
  {
    var temp := y;
    y := x % y;
    x := temp;
  }
  
  result := x;
}