method solve(s: string) returns (result: string)
  ensures |result| == |s|
  ensures (forall i :: 0 <= i < |s| && !IsAlpha(s[i]) ==> 
    (HasLetters(s) ==> result[i] == s[i]) && 
    (!HasLetters(s) ==> result[i] == s[|s| - 1 - i]))
  ensures (forall i :: 0 <= i < |s| && IsAlpha(s[i]) && HasLetters(s) ==> 
    (IsLower(s[i]) ==> result[i] == ToUpper(s[i])) &&
    (!IsLower(s[i]) ==> result[i] == ToLower(s[i])))
{
  if !HasLetters(s) {
    result := ReverseString(s);
  } else {
    result := "";
    var i := 0;
    while i < |s|
      invariant 0 <= i <= |s|
      invariant |result| == i
      invariant forall j :: 0 <= j < i && IsAlpha(s[j]) ==> 
        (IsLower(s[j]) ==> result[j] == ToUpper(s[j])) &&
        (!IsLower(s[j]) ==> result[j] == ToLower(s[j]))
      invariant forall j :: 0 <= j < i && !IsAlpha(s[j]) ==> result[j] == s[j]
      decreases |s| - i
    {
      if IsAlpha(s[i]) {
        if IsLower(s[i]) {
          result := result + [ToUpper(s[i])];
        } else {
          result := result + [ToLower(s[i])];
        }
      } else {
        result := result + [s[i]];
      }
      i := i + 1;
    }
  }
}

function IsAlpha(c: char): bool
{
  ('a' <= c <= 'z') || ('A' <= c <= 'Z')
}

function IsLower(c: char): bool
  requires IsAlpha(c)
{
  'a' <= c <= 'z'
}

function ToUpper(c: char): char
  requires IsAlpha(c) && IsLower(c)
  ensures IsAlpha(ToUpper(c)) && !IsLower(ToUpper(c))
{
  (c as int - 'a' as int + 'A' as int) as char
}

function ToLower(c: char): char
  requires IsAlpha(c) && !IsLower(c)
  ensures IsAlpha(ToLower(c)) && IsLower(ToLower(c))
{
  (c as int - 'A' as int + 'a' as int) as char
}

function HasLetters(s: string): bool
{
  exists i :: 0 <= i < |s| && IsAlpha(s[i])
}

function ReverseString(s: string): string
  ensures |ReverseString(s)| == |s|
  ensures forall i :: 0 <= i < |s| ==> ReverseString(s)[i] == s[|s| - 1 - i]
{
  if |s| == 0 then ""
  else ReverseString(s[1..]) + [s[0]]
}