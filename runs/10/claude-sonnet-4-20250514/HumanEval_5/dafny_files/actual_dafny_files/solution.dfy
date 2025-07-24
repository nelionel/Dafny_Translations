method intersperse(numbers: seq<int>, delimeter: int) returns (result: seq<int>)
  ensures |numbers| == 0 ==> |result| == 0
  ensures |numbers| == 1 ==> result == numbers
  ensures |numbers| > 1 ==> |result| == 2 * |numbers| - 1
  ensures |numbers| > 1 ==> forall i :: 0 <= i < |numbers| ==> result[2*i] == numbers[i]
  ensures |numbers| > 1 ==> forall i :: 0 <= i < |numbers| - 1 ==> result[2*i + 1] == delimeter
{
  if |numbers| == 0 {
    return [];
  }
  
  result := [];
  var i := 0;
  
  while i < |numbers|
    invariant 0 <= i <= |numbers|
    invariant |result| == if i == 0 then 0 else 2 * i - 1
    invariant forall j :: 0 <= j < i ==> j < |numbers| && 2*j < |result| && result[2*j] == numbers[j]
    invariant forall j :: 0 <= j < i - 1 ==> 2*j + 1 < |result| && result[2*j + 1] == delimeter
    decreases |numbers| - i
  {
    result := result + [numbers[i]];
    
    if i < |numbers| - 1 {
      result := result + [delimeter];
    }
    
    i := i + 1;
  }
}