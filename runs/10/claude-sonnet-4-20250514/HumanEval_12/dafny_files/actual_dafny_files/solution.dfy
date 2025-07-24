method longest(strings: seq<string>) returns (result: string)
  ensures |strings| == 0 ==> result == ""
  ensures |strings| > 0 ==> (
    (exists idx :: 0 <= idx < |strings| && strings[idx] == result) &&
    (forall s :: s in strings ==> |s| <= |result|) &&
    (forall i :: 0 <= i < |strings| && |strings[i]| == |result| ==> 
      (forall j :: 0 <= j < i ==> |strings[j]| < |result|))
  )
{
  if |strings| == 0 {
    return "";
  }
  
  var longest_string := strings[0];
  var max_length := |strings[0]|;
  
  var i := 1;
  while i < |strings|
    invariant 1 <= i <= |strings|
    invariant longest_string == strings[0] || (exists k :: 1 <= k < i && strings[k] == longest_string)
    invariant max_length == |longest_string|
    invariant forall k :: 0 <= k < i ==> |strings[k]| <= max_length
    invariant forall k :: 0 <= k < i && |strings[k]| == max_length ==> longest_string == strings[k]
    decreases |strings| - i
  {
    if |strings[i]| > max_length {
      max_length := |strings[i]|;
      longest_string := strings[i];
    }
    i := i + 1;
  }
  
  return longest_string;
}