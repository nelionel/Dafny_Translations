method can_arrange(arr: seq<int>) returns (result: int)
  ensures result == -1 ==> (forall i :: 1 <= i < |arr| ==> arr[i] >= arr[i-1])
  ensures result >= 0 ==> (0 < result < |arr| && arr[result] < arr[result-1])
  ensures result >= 0 ==> (forall i :: result < i < |arr| ==> arr[i] >= arr[i-1])
{
  if |arr| <= 1 {
    return -1;
  }
  
  var i := |arr| - 1;
  while i > 0
    invariant 0 <= i < |arr|
    invariant forall j :: i < j < |arr| ==> arr[j] >= arr[j-1]
    decreases i
  {
    if arr[i] < arr[i-1] {
      return i;
    }
    i := i - 1;
  }
  
  return -1;
}