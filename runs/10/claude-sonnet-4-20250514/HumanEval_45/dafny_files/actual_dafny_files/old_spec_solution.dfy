method triangle_area(a: real, h: real) returns (area: real)
  requires a >= 0.0
  requires h >= 0.0
  ensures area >= 0.0
  ensures area == (a * h) / 2.0
{
    area := (a * h) / 2.0;
}