method unique_digits(x: seq<int>) returns (result: seq<int>)
    ensures forall i :: 0 <= i < |result| ==> has_only_odd_digits_pure(result[i])
    ensures forall i :: 0 <= i < |result| ==> result[i] in x
    ensures forall i, j :: 0 <= i < j < |result| ==> result[i] <= result[j]
{
    var filtered := filter_odd_digit_numbers(x);
    result := sort_sequence(filtered);
}

function has_only_odd_digits_pure(num: int): bool
    requires num >= 0
    decreases num
{
    if num == 0 then true
    else if (num % 10) % 2 == 0 then false
    else has_only_odd_digits_pure(num / 10)
}

method filter_odd_digit_numbers(x: seq<int>) returns (filtered: seq<int>)
    ensures forall i :: 0 <= i < |filtered| ==> filtered[i] in x
    ensures forall i :: 0 <= i < |filtered| ==> filtered[i] >= 0 && has_only_odd_digits_pure(filtered[i])
{
    filtered := [];
    var i := 0;
    while i < |x|
        invariant 0 <= i <= |x|
        invariant forall j :: 0 <= j < |filtered| ==> filtered[j] in x
        invariant forall j :: 0 <= j < |filtered| ==> filtered[j] >= 0 && has_only_odd_digits_pure(filtered[j])
    {
        if x[i] >= 0 && has_only_odd_digits_pure(x[i]) {
            filtered := filtered + [x[i]];
        }
        i := i + 1;
    }
}

method sort_sequence(s: seq<int>) returns (sorted_s: seq<int>)
    ensures |sorted_s| == |s|
    ensures forall i :: 0 <= i < |s| ==> s[i] in sorted_s
    ensures forall i :: 0 <= i < |sorted_s| ==> sorted_s[i] in s
    ensures forall i, j :: 0 <= i < j < |sorted_s| ==> sorted_s[i] <= sorted_s[j]
{
    if |s| <= 1 {
        return s;
    }
    
    sorted_s := s;
    var i := 0;
    while i < |sorted_s|
        invariant 0 <= i <= |sorted_s|
        invariant |sorted_s| == |s|
        invariant forall k :: 0 <= k < |s| ==> s[k] in sorted_s
        invariant forall k :: 0 <= k < |sorted_s| ==> sorted_s[k] in s
        invariant forall p, q :: 0 <= p < q < i ==> sorted_s[p] <= sorted_s[q]
    {
        var min_idx := i;
        var j := i + 1;
        while j < |sorted_s|
            invariant i <= min_idx < |sorted_s|
            invariant i + 1 <= j <= |sorted_s|
            invariant forall k :: i <= k < j ==> sorted_s[min_idx] <= sorted_s[k]
        {
            if sorted_s[j] < sorted_s[min_idx] {
                min_idx := j;
            }
            j := j + 1;
        }
        
        if min_idx != i {
            var temp := sorted_s[i];
            sorted_s := sorted_s[i := sorted_s[min_idx]][min_idx := temp];
        }
        i := i + 1;
    }
}