method sort_array(arr: seq<nat>) returns (result: seq<nat>)
  ensures |result| == |arr|
  ensures multiset(result) == multiset(arr)
  ensures |arr| <= 1 ==> result == arr
  ensures |arr| > 1 && (arr[0] + arr[|arr|-1]) % 2 == 1 ==> is_sorted_ascending(result)
  ensures |arr| > 1 && (arr[0] + arr[|arr|-1]) % 2 == 0 ==> is_sorted_descending(result)
{
  if |arr| <= 1 {
    return arr;
  }
  
  var first_last_sum := arr[0] + arr[|arr|-1];
  var arr_copy := arr;
  
  if first_last_sum % 2 == 1 {
    // Sort ascending
    arr_copy := bubble_sort_ascending(arr_copy);
  } else {
    // Sort descending  
    arr_copy := bubble_sort_descending(arr_copy);
  }
  
  return arr_copy;
}

method bubble_sort_ascending(arr: seq<nat>) returns (sorted: seq<nat>)
  ensures |sorted| == |arr|
  ensures multiset(sorted) == multiset(arr)
  ensures is_sorted_ascending(sorted)
{
  if |arr| <= 1 {
    return arr;
  }
  
  var a := arr;
  var n := |a|;
  var i := 0;
  
  while i < n
    invariant 0 <= i <= n
    invariant |a| == n
    invariant multiset(a) == multiset(arr)
    invariant forall k :: 0 <= k < i ==> forall j :: i <= j < n ==> a[k] <= a[j]
    invariant forall k :: 0 <= k < i-1 ==> a[k] <= a[k+1]
  {
    var j := 0;
    while j < n - 1 - i
      invariant 0 <= j <= n - 1 - i
      invariant |a| == n
      invariant multiset(a) == multiset(arr)
      invariant forall k :: 0 <= k < i ==> forall l :: i <= l < n ==> a[k] <= a[l]
      invariant forall k :: 0 <= k < i-1 ==> a[k] <= a[k+1]
      invariant forall k :: j+1 <= k < n - i ==> a[n-1-i] <= a[k]
    {
      if a[j] > a[j+1] {
        a := a[j := a[j+1]][j+1 := a[j]];
      }
      j := j + 1;
    }
    i := i + 1;
  }
  
  return a;
}

method bubble_sort_descending(arr: seq<nat>) returns (sorted: seq<nat>)
  ensures |sorted| == |arr|
  ensures multiset(sorted) == multiset(arr)
  ensures is_sorted_descending(sorted)
{
  if |arr| <= 1 {
    return arr;
  }
  
  var a := arr;
  var n := |a|;
  var i := 0;
  
  while i < n
    invariant 0 <= i <= n
    invariant |a| == n
    invariant multiset(a) == multiset(arr)
    invariant forall k :: 0 <= k < i ==> forall j :: i <= j < n ==> a[k] >= a[j]
    invariant forall k :: 0 <= k < i-1 ==> a[k] >= a[k+1]
  {
    var j := 0;
    while j < n - 1 - i
      invariant 0 <= j <= n - 1 - i
      invariant |a| == n
      invariant multiset(a) == multiset(arr)
      invariant forall k :: 0 <= k < i ==> forall l :: i <= l < n ==> a[k] >= a[l]
      invariant forall k :: 0 <= k < i-1 ==> a[k] >= a[k+1]
      invariant forall k :: j+1 <= k < n - i ==> a[n-1-i] >= a[k]
    {
      if a[j] < a[j+1] {
        a := a[j := a[j+1]][j+1 := a[j]];
      }
      j := j + 1;
    }
    i := i + 1;
  }
  
  return a;
}

predicate is_sorted_ascending(s: seq<nat>)
{
  forall i :: 0 <= i < |s| - 1 ==> s[i] <= s[i+1]
}

predicate is_sorted_descending(s: seq<nat>)
{
  forall i :: 0 <= i < |s| - 1 ==> s[i] >= s[i+1]
}