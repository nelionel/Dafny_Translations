method max_element(l: seq<int>) returns (max_val: int)
  requires |l| > 0
  ensures max_val in l
  ensures forall i :: 0 <= i < |l| ==> l[i] <= max_val
{
  max_val := l[0];
  var idx := 1;
  
  while idx < |l|
    invariant 1 <= idx <= |l|
    invariant max_val in l[0..idx]
    invariant forall j :: 0 <= j < idx ==> l[j] <= max_val
  {
    if l[idx] > max_val {
      max_val := l[idx];
    }
    idx := idx + 1;
  }
}