function abs(x: real): real
{
  if x >= 0.0 then x else -x
}

method find_closest_elements(numbers: seq<real>) returns (result: seq<real>)
  requires |numbers| >= 2
  ensures |result| == 2
  ensures result[0] <= result[1]
  ensures exists i, j :: 0 <= i < |numbers| && 0 <= j < |numbers| && i != j && 
          ((result[0] == numbers[i] && result[1] == numbers[j]) || 
           (result[0] == numbers[j] && result[1] == numbers[i]))
  ensures forall i, j :: 0 <= i < |numbers| && 0 <= j < |numbers| && i != j ==>
          abs(result[1] - result[0]) <= abs(numbers[j] - numbers[i])
{
  var min_diff := abs(numbers[1] - numbers[0]);
  var closest_i := 0;
  var closest_j := 1;
  
  var i := 0;
  while i < |numbers|
    invariant 0 <= i <= |numbers|
    invariant 0 <= closest_i < |numbers| && 0 <= closest_j < |numbers|
    invariant closest_i != closest_j
    invariant min_diff == abs(numbers[closest_j] - numbers[closest_i])
    invariant forall x, y :: 0 <= x < i && x < y < |numbers| ==>
              min_diff <= abs(numbers[y] - numbers[x])
    decreases |numbers| - i
  {
    var j := i + 1;
    while j < |numbers|
      invariant i + 1 <= j <= |numbers|
      invariant 0 <= closest_i < |numbers| && 0 <= closest_j < |numbers|
      invariant closest_i != closest_j
      invariant min_diff == abs(numbers[closest_j] - numbers[closest_i])
      invariant forall x, y :: 0 <= x < i && x < y < |numbers| ==>
                min_diff <= abs(numbers[y] - numbers[x])
      invariant forall y :: i + 1 <= y < j ==>
                min_diff <= abs(numbers[y] - numbers[i])
      decreases |numbers| - j
    {
      var diff := abs(numbers[j] - numbers[i]);
      if diff < min_diff {
        min_diff := diff;
        closest_i := i;
        closest_j := j;
      }
      j := j + 1;
    }
    i := i + 1;
  }
  
  if numbers[closest_i] <= numbers[closest_j] {
    result := [numbers[closest_i], numbers[closest_j]];
  } else {
    result := [numbers[closest_j], numbers[closest_i]];
  }
}