method next_smallest(lst: seq<int>) returns (result: int)
  ensures result == -1 || (exists i, j :: 0 <= i < j < |lst| && lst[i] != lst[j] && 
    (forall k :: 0 <= k < |lst| && lst[k] in lst ==> lst[k] >= result) &&
    (exists m :: 0 <= m < |lst| && lst[m] < result))
{
  if |lst| < 2 {
    return -1;
  }
  
  var unique_elements := remove_duplicates(lst);
  
  if |unique_elements| < 2 {
    return -1;
  }
  
  var sorted_unique := sort_sequence(unique_elements);
  return sorted_unique[1];
}

method remove_duplicates(s: seq<int>) returns (unique: seq<int>)
  ensures forall x :: x in unique <==> x in s
  ensures forall i, j :: 0 <= i < j < |unique| ==> unique[i] != unique[j]
  decreases |s|
{
  unique := [];
  var i := 0;
  
  while i < |s|
    invariant 0 <= i <= |s|
    invariant forall x :: x in unique <==> (x in s[..i] && x in s)
    invariant forall k, l :: 0 <= k < l < |unique| ==> unique[k] != unique[l]
    decreases |s| - i
  {
    if s[i] !in unique {
      unique := unique + [s[i]];
    }
    i := i + 1;
  }
}

method sort_sequence(s: seq<int>) returns (sorted_s: seq<int>)
  ensures |sorted_s| == |s|
  ensures multiset(sorted_s) == multiset(s)
  ensures forall i, j :: 0 <= i < j < |sorted_s| ==> sorted_s[i] <= sorted_s[j]
  decreases |s|
{
  if |s| <= 1 {
    return s;
  }
  
  sorted_s := s;
  var i := 0;
  
  while i < |sorted_s|
    invariant 0 <= i <= |sorted_s|
    invariant |sorted_s| == |s|
    invariant multiset(sorted_s) == multiset(s)
    invariant forall k, l :: 0 <= k < l < i ==> sorted_s[k] <= sorted_s[l]
    decreases |sorted_s| - i
  {
    var j := i + 1;
    while j < |sorted_s|
      invariant i < j <= |sorted_s|
      invariant |sorted_s| == |s|
      invariant multiset(sorted_s) == multiset(s)
      invariant forall k, l :: 0 <= k < l < i ==> sorted_s[k] <= sorted_s[l]
      invariant forall k :: i <= k < j ==> sorted_s[i] <= sorted_s[k]
      decreases |sorted_s| - j
    {
      if sorted_s[j] < sorted_s[i] {
        sorted_s := sorted_s[..i] + [sorted_s[j]] + sorted_s[i+1..j] + [sorted_s[i]] + sorted_s[j+1..];
      }
      j := j + 1;
    }
    i := i + 1;
  }
}