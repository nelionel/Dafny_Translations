method unique(l: seq<int>) returns (result: seq<int>)
  ensures |result| <= |l|
  ensures forall i, j :: 0 <= i < j < |result| ==> result[i] < result[j]  // sorted
  ensures forall i :: 0 <= i < |result| ==> result[i] in l  // all elements from original
  ensures forall x :: x in l ==> x in result  // all unique elements present
{
  var noDuplicates := removeDuplicates(l);
  result := insertionSort(noDuplicates);
}

method removeDuplicates(s: seq<int>) returns (result: seq<int>)
  ensures forall x :: x in result ==> x in s
  ensures forall x :: x in s ==> x in result
  ensures forall i, j :: 0 <= i < j < |result| ==> result[i] != result[j]
  decreases |s|
{
  result := [];
  var i := 0;
  while i < |s|
    invariant 0 <= i <= |s|
    invariant forall x :: x in result ==> x in s
    invariant forall x :: x in s[..i] && x !in result ==> exists j :: 0 <= j < i && s[j] == x && s[j] in result
    invariant forall x :: x in result ==> x in s[..i]
    invariant forall j, k :: 0 <= j < k < |result| ==> result[j] != result[k]
  {
    if s[i] !in result {
      result := result + [s[i]];
    }
    i := i + 1;
  }
}

method insertionSort(s: seq<int>) returns (sorted: seq<int>)
  ensures |sorted| == |s|
  ensures forall i :: 0 <= i < |sorted| ==> sorted[i] in s
  ensures forall x :: x in s ==> x in sorted
  ensures forall i, j :: 0 <= i < j < |sorted| ==> sorted[i] <= sorted[j]
  decreases |s|
{
  sorted := [];
  var i := 0;
  while i < |s|
    invariant 0 <= i <= |s|
    invariant |sorted| == i
    invariant forall j :: 0 <= j < i ==> s[j] in sorted
    invariant forall x :: x in sorted ==> x in s[..i]
    invariant forall j, k :: 0 <= j < k < |sorted| ==> sorted[j] <= sorted[k]
  {
    sorted := insertInOrder(sorted, s[i]);
    i := i + 1;
  }
}

method insertInOrder(sorted: seq<int>, elem: int) returns (result: seq<int>)
  requires forall i, j :: 0 <= i < j < |sorted| ==> sorted[i] <= sorted[j]
  ensures |result| == |sorted| + 1
  ensures elem in result
  ensures forall x :: x in sorted ==> x in result
  ensures forall i, j :: 0 <= i < j < |result| ==> result[i] <= result[j]
  decreases |sorted|
{
  var i := 0;
  while i < |sorted| && sorted[i] <= elem
    invariant 0 <= i <= |sorted|
  {
    i := i + 1;
  }
  result := sorted[..i] + [elem] + sorted[i..];
}