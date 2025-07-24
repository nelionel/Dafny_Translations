method sorted_list_sum(lst: seq<string>) returns (result: seq<string>)
    ensures forall i :: 0 <= i < |result| ==> |result[i]| % 2 == 0
    ensures forall i, j :: 0 <= i < j < |result| ==> 
        |result[i]| < |result[j]| || (|result[i]| == |result[j]| && result[i] <= result[j])
    ensures forall s :: s in result ==> s in lst && |s| % 2 == 0
    ensures forall s :: s in lst && |s| % 2 == 0 ==> s in result
{
    // Filter out strings with odd lengths
    var filtered := FilterEvenLength(lst);
    
    // Sort the filtered strings
    result := SortByLengthThenAlpha(filtered);
}

method FilterEvenLength(lst: seq<string>) returns (filtered: seq<string>)
    ensures forall s :: s in filtered ==> s in lst && |s| % 2 == 0
    ensures forall s :: s in lst && |s| % 2 == 0 ==> s in filtered
{
    filtered := [];
    var i := 0;
    while i < |lst|
        invariant 0 <= i <= |lst|
        invariant forall s :: s in filtered ==> s in lst && |s| % 2 == 0
        invariant forall j :: 0 <= j < i && |lst[j]| % 2 == 0 ==> lst[j] in filtered
        decreases |lst| - i
    {
        if |lst[i]| % 2 == 0 {
            filtered := filtered + [lst[i]];
        }
        i := i + 1;
    }
}

method SortByLengthThenAlpha(lst: seq<string>) returns (sorted: seq<string>)
    ensures |sorted| == |lst|
    ensures forall s :: s in sorted <==> s in lst
    ensures forall i, j :: 0 <= i < j < |sorted| ==> 
        |sorted[i]| < |sorted[j]| || (|sorted[i]| == |sorted[j]| && sorted[i] <= sorted[j])
{
    sorted := [];
    var i := 0;
    
    while i < |lst|
        invariant 0 <= i <= |lst|
        invariant |sorted| == i
        invariant forall k :: 0 <= k < i ==> lst[k] in sorted
        invariant forall j, k :: 0 <= j < k < |sorted| ==> 
            |sorted[j]| < |sorted[k]| || (|sorted[j]| == |sorted[k]| && sorted[j] <= sorted[k])
        decreases |lst| - i
    {
        sorted := InsertSorted(sorted, lst[i]);
        i := i + 1;
    }
}

method InsertSorted(sorted_seq: seq<string>, item: string) returns (result: seq<string>)
    requires forall i, j :: 0 <= i < j < |sorted_seq| ==> 
        |sorted_seq[i]| < |sorted_seq[j]| || (|sorted_seq[i]| == |sorted_seq[j]| && sorted_seq[i] <= sorted_seq[j])
    ensures |result| == |sorted_seq| + 1
    ensures item in result
    ensures forall s :: s in sorted_seq ==> s in result
    ensures forall i, j :: 0 <= i < j < |result| ==> 
        |result[i]| < |result[j]| || (|result[i]| == |result[j]| && result[i] <= result[j])
{
    var pos := 0;
    while pos < |sorted_seq| && ShouldComeBefore(sorted_seq[pos], item)
        invariant 0 <= pos <= |sorted_seq|
        decreases |sorted_seq| - pos
    {
        pos := pos + 1;
    }
    
    result := sorted_seq[..pos] + [item] + sorted_seq[pos..];
}

predicate ShouldComeBefore(a: string, b: string)
{
    |a| < |b| || (|a| == |b| && a <= b)
}