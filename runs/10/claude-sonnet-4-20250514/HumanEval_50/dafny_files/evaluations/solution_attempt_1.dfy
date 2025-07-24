method decode_shift(s: string) returns (result: string)
  requires forall i :: 0 <= i < |s| ==> 'a' <= s[i] <= 'z'
  ensures |result| == |s|
  ensures forall i :: 0 <= i < |result| ==> 'a' <= result[i] <= 'z'
  ensures forall i :: 0 <= i < |result| ==> 
    result[i] == (((s[i] as int - 'a' as int - 5 + 26) % 26) + 'a' as int) as char
{
  result := "";
  var i := 0;
  
  while i < |s|
    invariant 0 <= i <= |s|
    invariant |result| == i
    invariant forall j :: 0 <= j < |result| ==> 'a' <= result[j] <= 'z'
    invariant forall j :: 0 <= j < |result| ==> 
      result[j] == (((s[j] as int - 'a' as int - 5 + 26) % 26) + 'a' as int) as char
  {
    var ch := s[i];
    var pos := (ch as int) - ('a' as int);
    var shifted_pos := (pos - 5 + 26) % 26;
    var decoded_char := (shifted_pos + ('a' as int)) as char;
    result := result + [decoded_char];
    i := i + 1;
  }
}