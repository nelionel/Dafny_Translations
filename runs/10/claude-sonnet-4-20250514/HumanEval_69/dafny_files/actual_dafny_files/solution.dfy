method search(lst: seq<int>) returns (result: int)
    requires |lst| > 0
    requires forall i :: 0 <= i < |lst| ==> lst[i] > 0
    ensures result == -1 ==> forall x :: x in lst ==> countOccurrences(lst, x) < x
    ensures result > 0 ==> result in lst && countOccurrences(lst, result) >= result &&
                          forall x :: x in lst && countOccurrences(lst, x) >= x ==> x <= result
{
    // Count frequencies and find valid numbers
    var validNumbers: seq<int> := [];
    var i := 0;
    
    while i < |lst|
        invariant 0 <= i <= |lst|
        invariant forall x :: x in validNumbers ==> x in lst && countOccurrences(lst, x) >= x
        invariant forall x :: x in lst[..i] && countOccurrences(lst, x) >= x ==> x in validNumbers
    {
        var current := lst[i];
        var freq := countOccurrences(lst, current);
        
        if freq >= current && current !in validNumbers {
            validNumbers := validNumbers + [current];
        }
        i := i + 1;
    }
    
    // Find maximum of valid numbers
    if |validNumbers| == 0 {
        result := -1;
    } else {
        result := findMax(validNumbers);
    }
}

function countOccurrences(lst: seq<int>, target: int): int
    ensures countOccurrences(lst, target) >= 0
    ensures countOccurrences(lst, target) == 0 <==> target !in lst
{
    if |lst| == 0 then 0
    else if lst[0] == target then 1 + countOccurrences(lst[1..], target)
    else countOccurrences(lst[1..], target)
}

function findMax(lst: seq<int>): int
    requires |lst| > 0
    ensures findMax(lst) in lst
    ensures forall x :: x in lst ==> x <= findMax(lst)
    decreases |lst|
{
    if |lst| == 1 then lst[0]
    else 
        var maxRest := findMax(lst[1..]);
        if lst[0] >= maxRest then lst[0] else maxRest
}