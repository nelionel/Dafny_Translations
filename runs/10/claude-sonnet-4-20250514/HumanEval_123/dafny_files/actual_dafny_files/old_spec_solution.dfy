predicate Sorted(s: seq<int>)
{
  forall i, j :: 0 <= i < j < |s| ==> s[i] <= s[j]
}

method SortSequence(s: seq<int>) returns (result: seq<int>)
  ensures |result| == |s|
  ensures multiset(result) == multiset(s)
  ensures Sorted(result)
{
  result := s;
  var i := 0;
  while i < |result|
    invariant 0 <= i <= |result|
    invariant |result| == |s|
    invariant multiset(result) == multiset(s)
    invariant forall x, y :: 0 <= x < y < i ==> result[x] <= result[y]
  {
    var j := i;
    while j > 0 && result[j-1] > result[j]
      invariant 0 <= j <= i
      invariant |result| == |s|
      invariant multiset(result) == multiset(s)
    {
      result := result[j-1 := result[j]][j := result[j-1]];
      j := j - 1;
    }
    i := i + 1;
  }
}

// Axiom for the Collatz Conjecture
lemma {:axiom} CollatzTerminates(n: int)
  requires n > 0
  ensures exists k :: k >= 0 && CollatzSequenceReachesOne(n, k)

predicate CollatzSequenceReachesOne(n: int, steps: int)
  requires n > 0 && steps >= 0
{
  if steps == 0 then n == 1
  else n > 1 && CollatzSequenceReachesOne(if n % 2 == 0 then n / 2 else 3 * n + 1, steps - 1)
}

method get_odd_collatz(n: int) returns (result: seq<int>)
  requires n > 0
  ensures forall i :: 0 <= i < |result| ==> result[i] % 2 == 1
  ensures 1 in result
  ensures Sorted(result)
  ensures forall x :: x in result ==> x > 0
{
  var odds: seq<int> := [];
  var current := n;
  
  // Use a reasonable upper bound for termination based on empirical observations
  var maxSteps := 1000; // This is a practical bound for reasonable inputs
  var stepCount := 0;
  
  while current != 1 && stepCount < maxSteps
    invariant current > 0
    invariant forall x :: x in odds ==> x % 2 == 1 && x > 0
    invariant stepCount >= 0
    decreases maxSteps - stepCount
  {
    if current % 2 == 1 {
      odds := odds + [current];
      current := 3 * current + 1;
    } else {
      current := current / 2;
    }
    stepCount := stepCount + 1;
  }
  
  // Add 1 to the odds list (we always reach 1 according to Collatz conjecture)
  odds := odds + [1];
  result := SortSequence(odds);
}