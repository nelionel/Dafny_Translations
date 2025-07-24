method is_happy(s: string) returns (result: bool)
  ensures result == (|s| >= 3 && forall i :: 0 <= i <= |s| - 3 ==> 
    s[i] != s[i+1] && s[i] != s[i+2] && s[i+1] != s[i+2])
{
  if |s| < 3 {
    return false;
  }
  
  var i := 0;
  while i <= |s| - 3
    invariant 0 <= i <= |s| - 2
    invariant forall j :: 0 <= j < i ==> 
      s[j] != s[j+1] && s[j] != s[j+2] && s[j+1] != s[j+2]
    decreases |s| - 3 - i
  {
    if s[i] == s[i+1] || s[i] == s[i+2] || s[i+1] == s[i+2] {
      return false;
    }
    i := i + 1;
  }
  
  return true;
}