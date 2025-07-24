method common(l1: seq<int>, l2: seq<int>) returns (result: seq<int>)
  ensures forall x :: x in result ==> x in l1 && x in l2
  ensures forall i, j :: 0 <= i < j < |result| ==> result[i] < result[j]
  ensures forall i, j :: 0 <= i < j < |result| ==> result[i] != result[j]
{
  // Find common elements without duplicates
  var commons := [];
  var i := 0;
  
  while i < |l1|
    invariant 0 <= i <= |l1|
    invariant forall x :: x in commons ==> x in l1 && x in l2
    invariant forall x, y :: x in commons && y in commons && x != y ==> x != y
    decreases |l1| - i
  {
    if inSeq(l1[i], l2) && !inSeq(l1[i], commons) {
      commons := commons + [l1[i]];
    }
    i := i + 1;
  }
  
  // Sort the result
  result := insertionSort(commons);
}

function inSeq(x: int, s: seq<int>): bool
{
  x in s
}

method insertionSort(s: seq<int>) returns (sorted: seq<int>)
  ensures |sorted| == |s|
  ensures forall x :: x in s <==> x in sorted
  ensures forall i, j :: 0 <= i < j < |sorted| ==> sorted[i] <= sorted[j]
{
  sorted := [];
  var i := 0;
  
  while i < |s|
    invariant 0 <= i <= |s|
    invariant |sorted| == i
    invariant forall k :: 0 <= k < i ==> s[k] in sorted
    invariant forall x :: x in sorted ==> x in s[0..i]
    invariant forall p, q :: 0 <= p < q < |sorted| ==> sorted[p] <= sorted[q]
    decreases |s| - i
  {
    sorted := insertSorted(sorted, s[i]);
    i := i + 1;
  }
}

method insertSorted(sorted: seq<int>, x: int) returns (result: seq<int>)
  requires forall i, j :: 0 <= i < j < |sorted| ==> sorted[i] <= sorted[j]
  ensures |result| == |sorted| + 1
  ensures x in result
  ensures forall y :: y in sorted ==> y in result
  ensures forall i, j :: 0 <= i < j < |result| ==> result[i] <= result[j]
{
  var pos := 0;
  
  while pos < |sorted| && sorted[pos] <= x
    invariant 0 <= pos <= |sorted|
    invariant forall k :: 0 <= k < pos ==> sorted[k] <= x
    decreases |sorted| - pos
  {
    pos := pos + 1;
  }
  
  result := sorted[0..pos] + [x] + sorted[pos..];
}