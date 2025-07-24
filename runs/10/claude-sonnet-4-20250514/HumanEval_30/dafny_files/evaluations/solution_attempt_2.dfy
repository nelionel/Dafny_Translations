method get_positive(l: seq<int>) returns (result: seq<int>)
  ensures forall i :: 0 <= i < |result| ==> result[i] > 0
  ensures forall i :: 0 <= i < |result| ==> result[i] in l
  ensures forall i :: 0 <= i < |l| && l[i] > 0 ==> l[i] in result
  ensures |result| == |seq i | 0 <= i < |l| && l[i] > 0|
  ensures forall i, j :: 0 <= i < j < |result| ==> 
    exists i', j' :: 0 <= i' < j' < |l| && l[i'] == result[i] && l[j'] == result[j] && l[i'] > 0 && l[j'] > 0
{
  result := [];
  var i := 0;
  while i < |l|
    invariant 0 <= i <= |l|
    invariant forall j :: 0 <= j < |result| ==> result[j] > 0
    invariant forall j :: 0 <= j < |result| ==> result[j] in l
    invariant forall j :: 0 <= j < i && l[j] > 0 ==> l[j] in result
    invariant |result| == |seq j | 0 <= j < i && l[j] > 0|
    invariant forall x, y :: 0 <= x < y < |result| ==> 
      exists x', y' :: 0 <= x' < y' < i && l[x'] == result[x] && l[y'] == result[y] && l[x'] > 0 && l[y'] > 0
  {
    if l[i] > 0 {
      result := result + [l[i]];
    }
    i := i + 1;
  }
}