method pluck(arr: seq<int>) returns (result: seq<int>)
    requires forall i :: 0 <= i < |arr| ==> arr[i] >= 0
    ensures |result| == 0 || |result| == 2
    ensures |result| == 0 ==> (|arr| == 0 || forall i :: 0 <= i < |arr| ==> arr[i] % 2 == 1)
    ensures |result| == 2 ==> (
        0 <= result[1] < |arr| &&
        arr[result[1]] == result[0] &&
        result[0] % 2 == 0 &&
        forall i :: 0 <= i < |arr| && arr[i] % 2 == 0 ==> result[0] <= arr[i] &&
        forall i :: 0 <= i < |arr| && arr[i] % 2 == 0 && arr[i] == result[0] ==> result[1] <= i
    )
{
    if |arr| == 0 {
        return [];
    }
    
    var smallestEven: int := -1;
    var smallestIndex: int := -1;
    var found: bool := false;
    
    var i: int := 0;
    while i < |arr|
        invariant 0 <= i <= |arr|
        invariant found ==> (
            0 <= smallestIndex < i &&
            arr[smallestIndex] == smallestEven &&
            smallestEven % 2 == 0 &&
            forall j :: 0 <= j < i && arr[j] % 2 == 0 ==> smallestEven <= arr[j] &&
            forall j :: 0 <= j < i && arr[j] % 2 == 0 && arr[j] == smallestEven ==> smallestIndex <= j
        )
        invariant !found ==> forall j :: 0 <= j < i ==> arr[j] % 2 == 1
        decreases |arr| - i
    {
        if arr[i] % 2 == 0 {
            if !found || arr[i] < smallestEven {
                smallestEven := arr[i];
                smallestIndex := i;
                found := true;
            }
        }
        i := i + 1;
    }
    
    if !found {
        return [];
    } else {
        return [smallestEven, smallestIndex];
    }
}