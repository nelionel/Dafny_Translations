predicate IsNonDecreasing(s: seq<int>)
{
  forall i :: 0 <= i < |s| - 1 ==> s[i] <= s[i + 1]
}

predicate IsNonIncreasing(s: seq<int>)
{
  forall i :: 0 <= i < |s| - 1 ==> s[i] >= s[i + 1]
}

method CheckNonDecreasing(s: seq<int>) returns (result: bool)
  ensures result <==> IsNonDecreasing(s)
{
  if |s| <= 1 {
    return true;
  }
  
  var i := 0;
  while i < |s| - 1
    invariant 0 <= i <= |s| - 1
    invariant forall j :: 0 <= j < i ==> s[j] <= s[j + 1]
  {
    if s[i] > s[i + 1] {
      return false;
    }
    i := i + 1;
  }
  return true;
}

method CheckNonIncreasing(s: seq<int>) returns (result: bool)
  ensures result <==> IsNonIncreasing(s)
{
  if |s| <= 1 {
    return true;
  }
  
  var i := 0;
  while i < |s| - 1
    invariant 0 <= i <= |s| - 1
    invariant forall j :: 0 <= j < i ==> s[j] >= s[j + 1]
  {
    if s[i] < s[i + 1] {
      return false;
    }
    i := i + 1;
  }
  return true;
}

method monotonic(l: seq<int>) returns (result: bool)
  ensures result <==> (|l| <= 1 || IsNonDecreasing(l) || IsNonIncreasing(l))
{
  if |l| <= 1 {
    return true;
  }
  
  var increasing := CheckNonDecreasing(l);
  var decreasing := CheckNonIncreasing(l);
  
  return increasing || decreasing;
}