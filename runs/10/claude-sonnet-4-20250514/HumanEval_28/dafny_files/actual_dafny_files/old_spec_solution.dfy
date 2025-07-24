method concatenate(strings: seq<string>) returns (result: string)
  decreases strings
  ensures |strings| == 0 ==> result == ""
{
  if |strings| == 0 {
    result := "";
  } else {
    var restResult := concatenate(strings[1..]);
    result := strings[0] + restResult;
  }
}