method median(l: seq<real>) returns (result: real)
  requires |l| > 0
  ensures |l| % 2 == 1 ==> exists sorted_l :: multiset(sorted_l) == multiset(l) && is_sorted(sorted_l) && result == sorted_l[|l| / 2]
  ensures |l| % 2 == 0 ==> exists sorted_l :: multiset(sorted_l) == multiset(l) && is_sorted(sorted_l) && result == (sorted_l[|l| / 2 - 1] + sorted_l[|l| / 2]) / 2.0
{
  var sorted_list := sort(l);
  var n := |sorted_list|;
  
  if n % 2 == 1 {
    result := sorted_list[n / 2];
  } else {
    var mid1 := sorted_list[n / 2 - 1];
    var mid2 := sorted_list[n / 2];
    result := (mid1 + mid2) / 2.0;
  }
}

method sort(s: seq<real>) returns (result: seq<real>)
  ensures multiset(result) == multiset(s)
  ensures is_sorted(result)
  decreases |s|
{
  if |s| <= 1 {
    result := s;
  } else {
    result := [];
    var i := 0;
    while i < |s|
      invariant 0 <= i <= |s|
      invariant multiset(result) == multiset(s[..i])
      invariant is_sorted(result)
      decreases |s| - i
    {
      result := insert_sorted(result, s[i]);
      i := i + 1;
    }
  }
}

method insert_sorted(sorted_seq: seq<real>, elem: real) returns (result: seq<real>)
  requires is_sorted(sorted_seq)
  ensures is_sorted(result)
  ensures multiset(result) == multiset(sorted_seq) + multiset([elem])
  decreases |sorted_seq|
{
  if |sorted_seq| == 0 {
    result := [elem];
  } else if elem <= sorted_seq[0] {
    result := [elem] + sorted_seq;
  } else {
    var rest_inserted := insert_sorted(sorted_seq[1..], elem);
    result := [sorted_seq[0]] + rest_inserted;
  }
}

predicate is_sorted(s: seq<real>)
{
  forall i, j :: 0 <= i <= j < |s| ==> s[i] <= s[j]
}