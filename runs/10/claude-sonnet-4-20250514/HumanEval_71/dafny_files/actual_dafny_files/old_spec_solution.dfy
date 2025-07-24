// Helper function to compute absolute value
function Abs(x: real): real
{
  if x >= 0.0 then x else -x
}

// Newton's method for square root with fixed iterations
function SqrtNewton(x: real, guess: real, iterations: nat): real
  requires x >= 0.0
  requires guess > 0.0
  decreases iterations
{
  if iterations == 0 then
    guess
  else
    var next_guess := (guess + x / guess) / 2.0;
    SqrtNewton(x, next_guess, iterations - 1)
}

// Square root function using Newton's method
function Sqrt(x: real): real
  requires x >= 0.0
{
  if x == 0.0 then 0.0
  else if x == 1.0 then 1.0
  else SqrtNewton(x, x / 2.0, 20) // 20 iterations should be sufficient for good precision
}

// Floor function implementation
function Floor(x: real): real
{
  if x >= 0.0 then
    var int_part := x as int;
    int_part as real
  else
    var int_part := x as int;
    if (int_part as real) == x then int_part as real
    else (int_part - 1) as real
}

// Helper function to round a real number to 2 decimal places
function RoundTo2Decimals(x: real): real
{
  var scaled := x * 100.0;
  var rounded := if scaled - Floor(scaled) >= 0.5 then Floor(scaled) + 1.0 else Floor(scaled);
  rounded / 100.0
}

method triangle_area(a: real, b: real, c: real) returns (result: real)
  requires a > 0.0 && b > 0.0 && c > 0.0
  ensures (a + b > c && a + c > b && b + c > a) ==> result >= 0.0
  ensures !(a + b > c && a + c > b && b + c > a) ==> result == -1.0
{
  // Check if the three sides form a valid triangle using triangle inequality
  if a + b > c && a + c > b && b + c > a {
    // Calculate the semi-perimeter
    var s := (a + b + c) / 2.0;
    
    // Use Heron's formula to calculate the area
    // Area = sqrt(s * (s-a) * (s-b) * (s-c))
    var area_squared := s * (s - a) * (s - b) * (s - c);
    var area := Sqrt(area_squared);
    
    // Round to 2 decimal places
    result := RoundTo2Decimals(area);
  } else {
    // Invalid triangle
    result := -1.0;
  }
}