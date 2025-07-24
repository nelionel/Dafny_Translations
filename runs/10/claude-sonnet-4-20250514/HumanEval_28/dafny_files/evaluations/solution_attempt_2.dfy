method concatenate(strings: seq<string>) returns (result: string)
  decreases strings
  ensures |strings| == 0 ==> result == ""
  ensures |strings| == 1 ==> result == strings[0]
  ensures |strings| > 1 ==> result == strings[0] + concatenate(strings[1..])
  ensures forall i :: 0 <= i < |strings| ==> |strings[i]| <= |result|
{
  if |strings| == 0 {
    result := "";
  } else {
    var restResult := concatenate(strings[1..]);
    result := strings[0] + restResult;
  }
}