function Join(strings: seq<string>): string
{
  if |strings| == 0 then ""
  else strings[0] + Join(strings[1..])
}

method concatenate(strings: seq<string>) returns (result: string)
  decreases strings
  ensures result == Join(strings)
{
  if |strings| == 0 {
    result := "";
  } else {
    var restResult := concatenate(strings[1..]);
    result := strings[0] + restResult;
  }
}