method vowels_count(s: string) returns (count: int)
  ensures count >= 0
  ensures count <= |s|
{
  if |s| == 0 {
    return 0;
  }
  
  count := 0;
  var i := 0;
  
  // Count regular vowels throughout the string
  while i < |s|
    invariant 0 <= i <= |s|
    invariant count >= 0
    invariant count <= i
    decreases |s| - i
  {
    var c := s[i];
    if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
       c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U' {
      count := count + 1;
    }
    i := i + 1;
  }
  
  // Check if 'y' or 'Y' is at the end
  var lastChar := s[|s| - 1];
  if lastChar == 'y' || lastChar == 'Y' {
    count := count + 1;
  }
}