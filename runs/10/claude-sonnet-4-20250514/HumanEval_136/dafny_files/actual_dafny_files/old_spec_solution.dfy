method largest_smallest_integers(lst: seq<int>) returns (result: seq<int>)
  ensures |result| == 4
  ensures result[0] == 0 || result[0] == 1  // has_negative flag
  ensures result[2] == 0 || result[2] == 1  // has_positive flag
  ensures result[0] == 1 ==> result[1] < 0   // if has negative, it's actually negative
  ensures result[2] == 1 ==> result[3] > 0   // if has positive, it's actually positive
  ensures result[0] == 1 ==> (exists i :: 0 <= i < |lst| && lst[i] == result[1] && lst[i] < 0)
  ensures result[2] == 1 ==> (exists i :: 0 <= i < |lst| && lst[i] == result[3] && lst[i] > 0)
  ensures result[0] == 1 ==> (forall i :: 0 <= i < |lst| && lst[i] < 0 ==> lst[i] <= result[1])
  ensures result[2] == 1 ==> (forall i :: 0 <= i < |lst| && lst[i] > 0 ==> lst[i] >= result[3])
{
  var negative_integers: seq<int> := [];
  var positive_integers: seq<int> := [];
  
  // Filter negative and positive integers
  var i := 0;
  while i < |lst|
    invariant 0 <= i <= |lst|
    invariant forall j :: 0 <= j < |negative_integers| ==> negative_integers[j] < 0
    invariant forall j :: 0 <= j < |positive_integers| ==> positive_integers[j] > 0
    invariant forall j :: 0 <= j < |negative_integers| ==> (exists k :: 0 <= k < i && lst[k] == negative_integers[j])
    invariant forall j :: 0 <= j < |positive_integers| ==> (exists k :: 0 <= k < i && lst[k] == positive_integers[j])
    invariant forall k :: 0 <= k < i && lst[k] < 0 ==> lst[k] in negative_integers
    invariant forall k :: 0 <= k < i && lst[k] > 0 ==> lst[k] in positive_integers
    decreases |lst| - i
  {
    if lst[i] < 0 {
      negative_integers := negative_integers + [lst[i]];
    } else if lst[i] > 0 {
      positive_integers := positive_integers + [lst[i]];
    }
    i := i + 1;
  }
  
  var has_negative := if |negative_integers| > 0 then 1 else 0;
  var largest_negative := 0;
  if |negative_integers| > 0 {
    largest_negative := negative_integers[0];
    var j := 1;
    while j < |negative_integers|
      invariant 1 <= j <= |negative_integers|
      invariant largest_negative in negative_integers
      invariant forall k :: 0 <= k < j ==> negative_integers[k] <= largest_negative
      decreases |negative_integers| - j
    {
      if negative_integers[j] > largest_negative {
        largest_negative := negative_integers[j];
      }
      j := j + 1;
    }
  }
  
  var has_positive := if |positive_integers| > 0 then 1 else 0;
  var smallest_positive := 0;
  if |positive_integers| > 0 {
    smallest_positive := positive_integers[0];
    var k := 1;
    while k < |positive_integers|
      invariant 1 <= k <= |positive_integers|
      invariant smallest_positive in positive_integers
      invariant forall m :: 0 <= m < k ==> positive_integers[m] >= smallest_positive
      decreases |positive_integers| - k
    {
      if positive_integers[k] < smallest_positive {
        smallest_positive := positive_integers[k];
      }
      k := k + 1;
    }
  }
  
  result := [has_negative, largest_negative, has_positive, smallest_positive];
}