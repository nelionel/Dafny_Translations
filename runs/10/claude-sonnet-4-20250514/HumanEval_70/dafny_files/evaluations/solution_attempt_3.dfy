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

// Helper predicate to check if a value is minimum in a sequence
predicate is_min_in_seq(value: int, s: seq<int>)
  requires |s| > 0
{
  value in s && forall x :: x in s ==> value <= x
}

// Helper predicate to check if a value is maximum in a sequence
predicate is_max_in_seq(value: int, s: seq<int>)
  requires |s| > 0
{
  value in s && forall x :: x in s ==> value >= x
}

// Function to simulate the remaining elements at step i
function remaining_at_step(lst: seq<int>, result_so_far: seq<int>): seq<int>
{
  if |result_so_far| == 0 then lst
  else remaining_at_step(remove_first_occurrence(lst, result_so_far[0]), result_so_far[1..])
}

method strange_sort_list(lst: seq<int>) returns (result: seq<int>)
  ensures |result| == |lst|
  ensures multiset(result) == multiset(lst)
  ensures |lst| == 0 ==> result == []
  ensures |lst| == 1 ==> result == lst
  ensures |lst| > 0 ==> result[0] == min_of_seq(lst)
  ensures |lst| > 1 ==> result[1] == max_of_seq(remove_first_occurrence(lst, result[0]))
  // Even indices (0, 2, 4, ...) are minimums of remaining elements at that step
  ensures forall i :: 0 <= i < |result| && i % 2 == 0 ==> 
    var remaining := remaining_at_step(lst, result[..i]);
    |remaining| > 0 && is_min_in_seq(result[i], remaining)
  // Odd indices (1, 3, 5, ...) are maximums of remaining elements at that step  
  ensures forall i :: 0 <= i < |result| && i % 2 == 1 ==> 
    var remaining := remaining_at_step(lst, result[..i]);
    |remaining| > 0 && is_max_in_seq(result[i], remaining)
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
    invariant |result| > 0 ==> (|result| % 2 == 1) == pick_min
    invariant remaining == remaining_at_step(lst, result)
    invariant forall i :: 0 <= i < |result| && i % 2 == 0 ==> 
      var rem_at_i := remaining_at_step(lst, result[..i]);
      |rem_at_i| > 0 && is_min_in_seq(result[i], rem_at_i)
    invariant forall i :: 0 <= i < |result| && i % 2 == 1 ==> 
      var rem_at_i := remaining_at_step(lst, result[..i]);
      |rem_at_i| > 0 && is_max_in_seq(result[i], rem_at_i)
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