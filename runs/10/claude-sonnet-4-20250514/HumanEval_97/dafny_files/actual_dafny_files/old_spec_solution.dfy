function abs(x: int): int
{
  if x >= 0 then x else -x
}

method multiply(a: int, b: int) returns (result: int)
  ensures result == (abs(a) % 10) * (abs(b) % 10)
  ensures 0 <= result <= 81
{
  var unit_a := abs(a) % 10;
  var unit_b := abs(b) % 10;
  result := unit_a * unit_b;
}