method count_distinct_characters(s: string) returns (count: int)
  ensures count >= 0
  ensures count <= |s|
  ensures count == |set c | c in s :: if 'A' <= c <= 'Z' then (c as int - 'A' as int + 'a' as int) as char else c|
{
  var distinct_chars: set<char> := {};
  var i := 0;
  
  while i < |s|
    invariant 0 <= i <= |s|
    invariant forall c :: c in distinct_chars ==> (('a' <= c <= 'z') || ('A' <= c <= 'Z') || ('0' <= c <= '9') || c == ' ' || c == '!' || c == '@' || c == '#' || c == '$' || c == '%' || c == '^' || c == '&' || c == '*' || c == '(' || c == ')' || c == '-' || c == '_' || c == '=' || c == '+' || c == '[' || c == ']' || c == '{' || c == '}' || c == '|' || c == '\\' || c == ':' || c == ';' || c == '"' || c == '\'' || c == '<' || c == '>' || c == ',' || c == '.' || c == '?' || c == '/')
    invariant distinct_chars == set c | c in s[..i] :: if 'A' <= c <= 'Z' then (c as int - 'A' as int + 'a' as int) as char else c
    decreases |s| - i
  {
    var c := s[i];
    var lower_c := if 'A' <= c <= 'Z' then (c as int - 'A' as int + 'a' as int) as char else c;
    distinct_chars := distinct_chars + {lower_c};
    i := i + 1;
  }
  
  count := |distinct_chars|;
}