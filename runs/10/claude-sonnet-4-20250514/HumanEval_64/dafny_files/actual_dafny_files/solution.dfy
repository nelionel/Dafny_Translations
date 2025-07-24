method vowels_count(s: string) returns (count: int)
  ensures count >= 0
  ensures count <= |s|
  ensures |s| == 0 ==> count == 0
  ensures |s| > 0 ==> count == CountRegularVowels(s) + (if s[|s|-1] == 'y' || s[|s|-1] == 'Y' then 1 else 0)
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
    invariant count == CountRegularVowels(s[..i])
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

function CountRegularVowels(s: string): int
{
  if |s| == 0 then 0
  else (if s[0] == 'a' || s[0] == 'e' || s[0] == 'i' || s[0] == 'o' || s[0] == 'u' ||
           s[0] == 'A' || s[0] == 'E' || s[0] == 'I' || s[0] == 'O' || s[0] == 'U'
        then 1 else 0) + CountRegularVowels(s[1..])
}