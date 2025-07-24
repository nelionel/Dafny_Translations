method maximum(arr: seq<int>, k: int) returns (result: seq<int>)
  requires k >= 0 && k <= |arr|
  requires |arr| >= 1
  ensures |result| == k
  ensures is_sorted_ascending(result)
  ensures forall x :: x in result ==> x in arr
  ensures k > 0 ==> (forall x :: x in result ==> (forall y :: y in arr && y !in result ==> x >= y))
{
  if k == 0 {
    return [];
  }
  
  var sorted_desc := sort_descending(arr);
  var k_largest := sorted_desc[..k];
  result := sort_ascending(k_largest);
}

predicate is_sorted_ascending(s: seq<int>)
{
  forall i, j :: 0 <= i < j < |s| ==> s[i] <= s[j]
}

predicate is_sorted_descending(s: seq<int>)
{
  forall i, j :: 0 <= i < j < |s| ==> s[i] >= s[j]
}

method sort_ascending(s: seq<int>) returns (result: seq<int>)
  ensures |result| == |s|
  ensures is_sorted_ascending(result)
  ensures forall x :: x in result ==> x in s
  ensures forall x :: x in s ==> x in result
  decreases |s|
{
  if |s| <= 1 {
    return s;
  }
  
  result := [s[0]];
  var i := 1;
  
  while i < |s|
    invariant 1 <= i <= |s|
    invariant |result| == i
    invariant is_sorted_ascending(result)
    invariant forall x :: x in result ==> x in s[..i]
    invariant forall x :: x in s[..i] ==> x in result
  {
    result := insert_ascending(result, s[i]);
    i := i + 1;
  }
}

method sort_descending(s: seq<int>) returns (result: seq<int>)
  ensures |result| == |s|
  ensures is_sorted_descending(result)
  ensures forall x :: x in result ==> x in s
  ensures forall x :: x in s ==> x in result
  decreases |s|
{
  if |s| <= 1 {
    return s;
  }
  
  result := [s[0]];
  var i := 1;
  
  while i < |s|
    invariant 1 <= i <= |s|
    invariant |result| == i
    invariant is_sorted_descending(result)
    invariant forall x :: x in result ==> x in s[..i]
    invariant forall x :: x in s[..i] ==> x in result
  {
    result := insert_descending(result, s[i]);
    i := i + 1;
  }
}

method insert_ascending(sorted_seq: seq<int>, elem: int) returns (result: seq<int>)
  requires is_sorted_ascending(sorted_seq)
  ensures |result| == |sorted_seq| + 1
  ensures is_sorted_ascending(result)
  ensures elem in result
  ensures forall x :: x in sorted_seq ==> x in result
  ensures forall x :: x in result ==> x == elem || x in sorted_seq
{
  var i := 0;
  while i < |sorted_seq| && sorted_seq[i] <= elem
    invariant 0 <= i <= |sorted_seq|
  {
    i := i + 1;
  }
  result := sorted_seq[..i] + [elem] + sorted_seq[i..];
}

method insert_descending(sorted_seq: seq<int>, elem: int) returns (result: seq<int>)
  requires is_sorted_descending(sorted_seq)
  ensures |result| == |sorted_seq| + 1
  ensures is_sorted_descending(result)
  ensures elem in result
  ensures forall x :: x in sorted_seq ==> x in result
  ensures forall x :: x in result ==> x == elem || x in sorted_seq
{
  var i := 0;
  while i < |sorted_seq| && sorted_seq[i] >= elem
    invariant 0 <= i <= |sorted_seq|
  {
    i := i + 1;
  }
  result := sorted_seq[..i] + [elem] + sorted_seq[i..];
}