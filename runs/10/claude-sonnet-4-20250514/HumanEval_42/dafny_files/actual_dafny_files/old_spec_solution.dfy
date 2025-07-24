method incr_list(l: seq<int>) returns (result: seq<int>)
  ensures |result| == |l|
  ensures forall i :: 0 <= i < |l| ==> result[i] == l[i] + 1
  decreases |l|
{
  if |l| == 0 {
    return [];
  } else {
    var rest := incr_list(l[1..]);
    return [l[0] + 1] + rest;
  }
}