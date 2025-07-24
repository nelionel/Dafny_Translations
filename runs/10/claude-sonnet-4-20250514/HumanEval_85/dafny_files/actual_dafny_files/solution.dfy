method add(lst: seq<int>) returns (result: int)
    requires |lst| > 0
    ensures result == SumEvenAtOddIndices(lst)
{
    var total := 0;
    var i := 1;
    
    while i < |lst|
        invariant 1 <= i
        invariant i % 2 == 1  // i is always odd
        invariant total == SumEvenAtOddIndicesUpTo(lst, i)
        decreases |lst| - i
    {
        if lst[i] % 2 == 0 {
            total := total + lst[i];
        }
        i := i + 2;
    }
    
    result := total;
}

function SumEvenAtOddIndices(lst: seq<int>): int
{
    SumEvenAtOddIndicesUpTo(lst, |lst|)
}

function SumEvenAtOddIndicesUpTo(lst: seq<int>, limit: int): int
    requires 0 <= limit <= |lst|
    decreases limit
{
    if limit <= 1 then 0
    else
        var prev := SumEvenAtOddIndicesUpTo(lst, limit - 1);
        var idx := limit - 1;
        if idx % 2 == 1 && lst[idx] % 2 == 0 then
            prev + lst[idx]
        else
            prev
}