method sort_third(l: seq<int>) returns (result: seq<int>)
  ensures |result| == |l|
  ensures forall i :: 0 <= i < |l| && i % 3 != 0 ==> result[i] == l[i]
  ensures forall i, j :: 0 <= i < j < |l| && i % 3 == 0 && j % 3 == 0 ==> 
    result[i] <= result[j]
  ensures multiset(seq(|l|, i requires 0 <= i < |l| => if i % 3 == 0 then result[i] else 0)) == 
          multiset(seq(|l|, i requires 0 <= i < |l| => if i % 3 == 0 then l[i] else 0))
{
  if |l| == 0 {
    return [];
  }
  
  result := l;
  
  // Extract elements at indices divisible by 3
  var third_elements: seq<int> := [];
  var third_indices: seq<int> := [];
  
  var i := 0;
  while i < |l|
    invariant 0 <= i <= |l|
    invariant |third_elements| == |third_indices|
    invariant forall k :: 0 <= k < |third_indices| ==> third_indices[k] % 3 == 0
    invariant forall k :: 0 <= k < |third_indices| ==> 0 <= third_indices[k] < |l|
    invariant forall k :: 0 <= k < |third_elements| ==> 
      exists j :: 0 <= j < i && j % 3 == 0 && third_elements[k] == l[j]
    decreases |l| - i
  {
    if i % 3 == 0 {
      third_elements := third_elements + [l[i]];
      third_indices := third_indices + [i];
    }
    i := i + 1;
  }
  
  // Sort the extracted elements using a simple insertion sort
  var sorted_elements := third_elements;
  if |sorted_elements| > 1 {
    var j := 1;
    while j < |sorted_elements|
      invariant 1 <= j <= |sorted_elements|
      invariant |sorted_elements| == |third_elements|
      invariant forall k1, k2 :: 0 <= k1 < k2 < j ==> sorted_elements[k1] <= sorted_elements[k2]
      decreases |sorted_elements| - j
    {
      var key := sorted_elements[j];
      var k := j - 1;
      
      while k >= 0 && sorted_elements[k] > key
        invariant -1 <= k < j
        invariant forall m :: k + 1 < m <= j ==> sorted_elements[m] > key
        decreases k + 1
      {
        sorted_elements := sorted_elements[k := sorted_elements[k + 1]];
        k := k - 1;
      }
      sorted_elements := sorted_elements[k + 1 := key];
      j := j + 1;
    }
  }
  
  // Put the sorted elements back at their respective indices
  var idx := 0;
  while idx < |third_indices|
    invariant 0 <= idx <= |third_indices|
    invariant |result| == |l|
    invariant forall k :: 0 <= k < |l| && k % 3 != 0 ==> result[k] == l[k]
    invariant forall k :: 0 <= k < idx ==> 
      exists m :: 0 <= m < |sorted_elements| && result[third_indices[k]] == sorted_elements[m]
    decreases |third_indices| - idx
  {
    result := result[third_indices[idx] := sorted_elements[idx]];
    idx := idx + 1;
  }
}