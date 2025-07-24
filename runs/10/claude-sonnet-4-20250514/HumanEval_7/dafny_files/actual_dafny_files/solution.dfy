method contains_substring(s: string, sub: string) returns (result: bool)
  ensures result <==> exists i :: 0 <= i <= |s| - |sub| && s[i..i+|sub|] == sub
{
  if |sub| > |s| {
    return false;
  }
  
  var i := 0;
  while i <= |s| - |sub|
    invariant 0 <= i <= |s| - |sub| + 1
    invariant forall j :: 0 <= j < i ==> s[j..j+|sub|] != sub
  {
    if s[i..i+|sub|] == sub {
      return true;
    }
    i := i + 1;
  }
  return false;
}

method filter_by_substring(strings: seq<string>, substring: string) returns (result: seq<string>)
  ensures forall s :: s in result ==> s in strings
  ensures forall s :: s in result ==> exists i :: 0 <= i <= |s| - |substring| && s[i..i+|substring|] == substring
  ensures forall s :: s in strings && (exists i :: 0 <= i <= |s| - |substring| && s[i..i+|substring|] == substring) ==> s in result
  ensures |result| <= |strings|
  ensures forall i, j :: 0 <= i < j < |strings| && strings[i] in result && strings[j] in result ==> 
    exists k, l :: 0 <= k < l < |result| && result[k] == strings[i] && result[l] == strings[j]
{
  result := [];
  var i := 0;
  
  while i < |strings|
    invariant 0 <= i <= |strings|
    invariant forall s :: s in result ==> s in strings
    invariant forall s :: s in result ==> exists j :: 0 <= j <= |s| - |substring| && s[j..j+|substring|] == substring
    invariant forall k :: 0 <= k < i ==> (strings[k] in result <==> exists j :: 0 <= j <= |strings[k]| - |substring| && strings[k][j..j+|substring|] == substring)
  {
    var contains := contains_substring(strings[i], substring);
    if contains {
      result := result + [strings[i]];
    }
    i := i + 1;
  }
}