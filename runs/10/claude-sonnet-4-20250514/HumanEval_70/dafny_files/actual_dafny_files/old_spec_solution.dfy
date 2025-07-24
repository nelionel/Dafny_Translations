function min_of_seq(s: seq<int>): int
  requires |s| > 0
{
  if |s| == 1 then s[0]
  else if s[0] <= min_of_seq(s[1..]) then s[0]
  else min_of_seq(s[1..])
}

function max_of_seq(s: seq<int>): int
  requires |s| > 0
{
  if |s| == 1 then s[0]
  else if s[0] >= max_of_seq(s[1..]) then s[0]
  else max_of_seq(s[1..])
}

function remove_first_occurrence(s: seq<int>, value: int): seq<int>
{
  if |s| == 0 then []
  else if s[0] == value then s[1..]
  else [s[0]] + remove_first_occurrence(s[1..], value)
}

method strange_sort_list(lst: seq<int>) returns (result: seq<int>)
  ensures |result| == |lst|
  ensures multiset(result) == multiset(lst)
{
  if |lst| == 0 {
    return [];
  }
  
  var remaining := lst;
  result := [];
  var pick_min := true;
  
  while |remaining| > 0
    invariant |result| + |remaining| == |lst|
    invariant multiset(result) + multiset(remaining) == multiset(lst)
    decreases |remaining|
  {
    var value: int;
    if pick_min {
      value := min_of_seq(remaining);
    } else {
      value := max_of_seq(remaining);
    }
    
    result := result + [value];
    remaining := remove_first_occurrence(remaining, value);
    pick_min := !pick_min;
  }
}