method get_positive(l: seq<int>) returns (result: seq<int>)
  ensures forall i :: 0 <= i < |result| ==> result[i] > 0
  ensures forall i :: 0 <= i < |result| ==> result[i] in l
  ensures forall i :: 0 <= i < |l| && l[i] > 0 ==> l[i] in result
  ensures forall i, j :: 0 <= i < j < |result| ==> 
    exists ii, jj :: 0 <= ii < jj < |l| && l[ii] == result[i] && l[jj] == result[j]
  ensures exists indices: seq<int> :: 
    |indices| == |result| &&
    (forall i :: 0 <= i < |indices| ==> 0 <= indices[i] < |l|) &&
    (forall i :: 0 <= i < |indices| ==> l[indices[i]] > 0) &&
    (forall i :: 0 <= i < |result| ==> result[i] == l[indices[i]]) &&
    (forall i, j :: 0 <= i < j < |indices| ==> indices[i] < indices[j]) &&
    (forall i :: 0 <= i < |l| && l[i] > 0 ==> exists j :: 0 <= j < |indices| && indices[j] == i)
{
  result := [];
  var i := 0;
  while i < |l|
    invariant 0 <= i <= |l|
    invariant forall j :: 0 <= j < |result| ==> result[j] > 0
    invariant forall j :: 0 <= j < |result| ==> result[j] in l
    invariant forall j :: 0 <= j < i && l[j] > 0 ==> l[j] in result
  {
    if l[i] > 0 {
      result := result + [l[i]];
    }
    i := i + 1;
  }
}