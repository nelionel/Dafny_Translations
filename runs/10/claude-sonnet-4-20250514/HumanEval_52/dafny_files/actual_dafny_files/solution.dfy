method below_threshold(l: seq<int>, t: int) returns (result: bool)
  ensures result == forall i :: 0 <= i < |l| ==> l[i] < t
{
  var index := 0;
  
  while index < |l|
    invariant 0 <= index <= |l|
    invariant forall j :: 0 <= j < index ==> l[j] < t
    decreases |l| - index
  {
    if l[index] >= t {
      return false;
    }
    index := index + 1;
  }
  
  return true;
}