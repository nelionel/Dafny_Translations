method add_elements(arr: seq<int>, k: int) returns (result: int)
    requires 1 <= |arr| <= 100
    requires 1 <= k <= |arr|
    ensures result == sumValidElements(arr, k)
{
    result := 0;
    var i := 0;
    
    while i < k
        invariant 0 <= i <= k
        invariant result == sumValidElementsUpTo(arr, i)
    {
        if hasAtMostTwoDigits(arr[i]) {
            result := result + arr[i];
        }
        i := i + 1;
    }
}

predicate hasAtMostTwoDigits(n: int) {
    if n >= 0 then n <= 99 else n >= -99
}

function sumValidElementsUpTo(arr: seq<int>, upTo: int): int
    requires 0 <= upTo <= |arr|
{
    if upTo == 0 then 0
    else if hasAtMostTwoDigits(arr[upTo-1]) then 
        arr[upTo-1] + sumValidElementsUpTo(arr, upTo-1)
    else 
        sumValidElementsUpTo(arr, upTo-1)
}

function sumValidElements(arr: seq<int>, k: int): int
    requires 0 <= k <= |arr|
{
    sumValidElementsUpTo(arr, k)
}