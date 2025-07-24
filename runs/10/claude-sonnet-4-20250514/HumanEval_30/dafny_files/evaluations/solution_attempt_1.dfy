method get_positive(l: seq<int>) returns (result: seq<int>)
  ensures forall i :: 0 <= i < |result| ==> result[i] > 0
  ensures forall i :: 0 <= i < |result| ==> result[i] in l
  ensures forall i :: 0 <= i < |l| && l[i] > 0 ==> l[i] in result
  ensures forall x :: count(result, x) == count_positive(l, x)
  ensures is_subsequence(result, l)
{
  result := [];
  var i := 0;
  while i < |l|
    invariant 0 <= i <= |l|
    invariant forall j :: 0 <= j < |result| ==> result[j] > 0
    invariant forall j :: 0 <= j < |result| ==> result[j] in l
    invariant forall j :: 0 <= j < i && l[j] > 0 ==> l[j] in result
    invariant forall x :: count(result, x) == count_positive(l[..i], x)
    invariant is_subsequence(result, l[..i])
  {
    if l[i] > 0 {
      result := result + [l[i]];
    }
    i := i + 1;
  }
}

function count(s: seq<int>, x: int): nat {
  if |s| == 0 then 0
  else (if s[0] == x then 1 else 0) + count(s[1..], x)
}

function count_positive(s: seq<int>, x: int): nat {
  if |s| == 0 then 0
  else (if s[0] == x && s[0] > 0 then 1 else 0) + count_positive(s[1..], x)
}

predicate is_subsequence(sub: seq<int>, super: seq<int>) {
  exists indices :: |indices| == |sub| && 
    (forall i :: 0 <= i < |indices| ==> 0 <= indices[i] < |super|) &&
    (forall i, j :: 0 <= i < j < |indices| ==> indices[i] < indices[j]) &&
    (forall i :: 0 <= i < |sub| ==> sub[i] == super[indices[i]])
}