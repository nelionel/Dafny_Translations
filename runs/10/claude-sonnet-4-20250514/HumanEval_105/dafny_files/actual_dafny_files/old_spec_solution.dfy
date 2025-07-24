function DigitToWord(digit: int): string
    requires 1 <= digit <= 9
{
    match digit
        case 1 => "One"
        case 2 => "Two"
        case 3 => "Three"
        case 4 => "Four"
        case 5 => "Five"
        case 6 => "Six"
        case 7 => "Seven"
        case 8 => "Eight"
        case 9 => "Nine"
}

function CountValidDigits(arr: seq<int>): int
{
    if |arr| == 0 then 0
    else (if 1 <= arr[0] <= 9 then 1 else 0) + CountValidDigits(arr[1..])
}

method by_length(arr: seq<int>) returns (result: seq<string>)
    ensures |result| == CountValidDigits(arr)
    ensures forall i :: 0 <= i < |result| ==> result[i] in ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
{
    // Filter to keep only digits 1-9
    var validDigits: seq<int> := [];
    var i := 0;
    while i < |arr|
        invariant 0 <= i <= |arr|
        invariant forall j :: 0 <= j < |validDigits| ==> 1 <= validDigits[j] <= 9
        invariant |validDigits| == CountValidDigits(arr[..i])
        decreases |arr| - i
    {
        if 1 <= arr[i] <= 9 {
            validDigits := validDigits + [arr[i]];
        }
        i := i + 1;
    }

    // Sort using insertion sort
    var sorted := validDigits;
    var j := 1;
    while j < |sorted|
        invariant 1 <= j <= |sorted|
        invariant forall k, l :: 0 <= k < l < j ==> sorted[k] <= sorted[l]
        invariant multiset(sorted) == multiset(validDigits)
        invariant forall k :: 0 <= k < |sorted| ==> 1 <= sorted[k] <= 9
        decreases |sorted| - j
    {
        var key := sorted[j];
        var k := j - 1;
        
        // Find position to insert key
        while k >= 0 && sorted[k] > key
            invariant -1 <= k < j
            invariant forall l :: k + 1 < l <= j ==> sorted[l] > key
            decreases k + 1
        {
            k := k - 1;
        }
        
        // Shift elements and insert key
        var insertPos := k + 1;
        sorted := sorted[..insertPos] + [key] + sorted[insertPos..j] + sorted[j+1..];
        j := j + 1;
    }

    // Reverse the sorted array
    var reversed: seq<int> := [];
    var m := |sorted| - 1;
    while m >= 0
        invariant -1 <= m < |sorted|
        invariant |reversed| == |sorted| - 1 - m
        invariant forall n :: 0 <= n < |reversed| ==> reversed[n] == sorted[|sorted| - 1 - n]
        invariant forall n :: 0 <= n < |reversed| ==> 1 <= reversed[n] <= 9
        decreases m + 1
    {
        reversed := reversed + [sorted[m]];
        m := m - 1;
    }

    // Convert digits to words
    result := [];
    var p := 0;
    while p < |reversed|
        invariant 0 <= p <= |reversed|
        invariant |result| == p
        invariant forall q :: 0 <= q < p ==> result[q] == DigitToWord(reversed[q])
        invariant forall q :: 0 <= q < p ==> result[q] in ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
        decreases |reversed| - p
    {
        result := result + [DigitToWord(reversed[p])];
        p := p + 1;
    }
}