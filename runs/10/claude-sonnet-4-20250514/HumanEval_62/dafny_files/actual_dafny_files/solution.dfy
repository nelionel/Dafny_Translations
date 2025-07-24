method derivative(xs: seq<real>) returns (result: seq<real>)
  ensures |xs| <= 1 ==> |result| == 0
  ensures |xs| > 1 ==> |result| == |xs| - 1
  ensures |xs| > 1 ==> forall i :: 0 <= i < |result| ==> result[i] == (i + 1) as real * xs[i + 1]
{
  if |xs| <= 1 {
    result := [];
  } else {
    result := [];
    var i := 1;
    while i < |xs|
      invariant 1 <= i <= |xs|
      invariant |result| == i - 1
      invariant forall j :: 0 <= j < |result| ==> result[j] == (j + 1) as real * xs[j + 1]
      decreases |xs| - i
    {
      result := result + [i as real * xs[i]];
      i := i + 1;
    }
  }
}