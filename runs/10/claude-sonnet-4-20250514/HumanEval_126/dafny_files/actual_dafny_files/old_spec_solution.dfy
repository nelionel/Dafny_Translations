method is_sorted(lst: seq<int>) returns (result: bool)
    requires forall i :: 0 <= i < |lst| ==> lst[i] >= 0  // assume no negative numbers
    ensures result <==> (|lst| <= 1 || (IsSortedAscending(lst) && NoMoreThanTwoDuplicates(lst)))
{
    // Handle empty list or single element
    if |lst| <= 1 {
        return true;
    }
    
    // Check if list is sorted in ascending order
    var i := 1;
    while i < |lst|
        invariant 1 <= i <= |lst|
        invariant forall j :: 1 <= j < i ==> lst[j-1] <= lst[j]
        decreases |lst| - i
    {
        if lst[i] < lst[i-1] {
            return false;
        }
        i := i + 1;
    }
    
    // Check if any number appears more than twice
    i := 0;
    while i < |lst|
        invariant 0 <= i <= |lst|
        invariant forall j :: 0 <= j < i ==> CountOccurrences(lst, lst[j]) <= 2
        decreases |lst| - i
    {
        var count := CountOccurrences(lst, lst[i]);
        if count > 2 {
            return false;
        }
        i := i + 1;
    }
    
    return true;
}

function CountOccurrences(s: seq<int>, x: int): int
    ensures CountOccurrences(s, x) >= 0
    decreases s
{
    if |s| == 0 then 0
    else if s[0] == x then 1 + CountOccurrences(s[1..], x)
    else CountOccurrences(s[1..], x)
}

predicate IsSortedAscending(s: seq<int>)
{
    forall i :: 1 <= i < |s| ==> s[i-1] <= s[i]
}

predicate NoMoreThanTwoDuplicates(s: seq<int>)
{
    forall i :: 0 <= i < |s| ==> CountOccurrences(s, s[i]) <= 2
}