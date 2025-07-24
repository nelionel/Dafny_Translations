method rolling_max(numbers: seq<int>) returns (result: seq<int>)
    ensures |result| == |numbers|
    ensures forall i :: 0 <= i < |result| ==> result[i] == max_up_to(numbers, i)
    ensures forall i :: 0 <= i < |result| - 1 ==> result[i] <= result[i+1]
{
    if |numbers| == 0 {
        return [];
    }
    
    result := [];
    var current_max := numbers[0];
    var index := 0;
    
    while index < |numbers|
        invariant 0 <= index <= |numbers|
        invariant |result| == index
        invariant index > 0 ==> current_max == max_up_to(numbers, index-1)
        invariant forall i :: 0 <= i < index ==> result[i] == max_up_to(numbers, i)
        invariant forall i :: 0 <= i < index - 1 ==> result[i] <= result[i+1]
        decreases |numbers| - index
    {
        if index == 0 {
            current_max := numbers[0];
        } else {
            current_max := if numbers[index] > current_max then numbers[index] else current_max;
        }
        result := result + [current_max];
        index := index + 1;
    }
}

function max_up_to(numbers: seq<int>, i: int): int
    requires 0 <= i < |numbers|
    decreases i
{
    if i == 0 then 
        numbers[0]
    else
        var prev_max := max_up_to(numbers, i-1);
        if numbers[i] > prev_max then numbers[i] else prev_max
}