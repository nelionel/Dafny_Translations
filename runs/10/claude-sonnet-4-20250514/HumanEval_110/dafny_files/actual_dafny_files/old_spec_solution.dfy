method exchange(lst1: seq<int>, lst2: seq<int>) returns (result: string)
  requires |lst1| > 0 && |lst2| > 0  // non-empty lists as stated in documentation
  ensures result == "YES" || result == "NO"
  ensures result == "YES" <==> (countEven(lst1) + countEven(lst2) >= |lst1|)
{
  var totalEven := 0;
  
  // Count even numbers in lst1
  var i := 0;
  while i < |lst1|
    invariant 0 <= i <= |lst1|
    invariant totalEven == countEvenUpTo(lst1, i)
  {
    if lst1[i] % 2 == 0 {
      totalEven := totalEven + 1;
    }
    i := i + 1;
  }
  
  // Count even numbers in lst2
  i := 0;
  while i < |lst2|
    invariant 0 <= i <= |lst2|
    invariant totalEven == countEven(lst1) + countEvenUpTo(lst2, i)
  {
    if lst2[i] % 2 == 0 {
      totalEven := totalEven + 1;
    }
    i := i + 1;
  }
  
  if totalEven >= |lst1| {
    result := "YES";
  } else {
    result := "NO";
  }
}

function countEven(s: seq<int>): int
  decreases |s|
{
  if |s| == 0 then 0
  else (if s[0] % 2 == 0 then 1 else 0) + countEven(s[1..])
}

function countEvenUpTo(s: seq<int>, n: int): int
  requires 0 <= n <= |s|
  decreases n
{
  if n == 0 then 0
  else (if s[n-1] % 2 == 0 then 1 else 0) + countEvenUpTo(s, n-1)
}

lemma CountEvenUpToComplete(s: seq<int>)
  ensures countEvenUpTo(s, |s|) == countEven(s)
{
  if |s| == 0 {
    // Base case: both functions return 0 for empty sequence
  } else {
    // Inductive case
    CountEvenUpToComplete(s[1..]);
    assert countEvenUpTo(s, |s|) == (if s[|s|-1] % 2 == 0 then 1 else 0) + countEvenUpTo(s, |s|-1);
    assert countEven(s) == (if s[0] % 2 == 0 then 1 else 0) + countEven(s[1..]);
  }
}