method solution(lst: seq<int>) returns (result: int)
    requires |lst| > 0
    ensures result == SumOddAtEvenPositions(lst)
{
    var total := 0;
    var i := 0;
    
    while i < |lst|
        invariant 0 <= i
        invariant i % 2 == 0
        invariant total == SumOddAtEvenPositionsUpTo(lst, i)
        decreases |lst| - i
    {
        if lst[i] % 2 == 1 {
            total := total + lst[i];
        }
        i := i + 2;
    }
    
    result := total;
}

function SumOddAtEvenPositions(lst: seq<int>): int
{
    SumOddAtEvenPositionsHelper(lst, 0)
}

function SumOddAtEvenPositionsHelper(lst: seq<int>, i: int): int
    requires 0 <= i
    decreases if i >= |lst| then 0 else |lst| - i
{
    if i >= |lst| then 0
    else if lst[i] % 2 == 1 then
        lst[i] + SumOddAtEvenPositionsHelper(lst, i + 2)
    else
        SumOddAtEvenPositionsHelper(lst, i + 2)
}

function SumOddAtEvenPositionsUpTo(lst: seq<int>, upTo: int): int
    requires 0 <= upTo
    decreases upTo
{
    if upTo == 0 then 0
    else if upTo <= 1 then
        if lst[0] % 2 == 1 then lst[0] else 0
    else
        var prevSum := SumOddAtEvenPositionsUpTo(lst, upTo - 2);
        if lst[upTo - 2] % 2 == 1 then
            prevSum + lst[upTo - 2]
        else
            prevSum
}