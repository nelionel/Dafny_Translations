method string_xor(a: string, b: string) returns (result: string)
    requires |a| == |b|
    requires forall i :: 0 <= i < |a| ==> (a[i] == '0' || a[i] == '1')
    requires forall i :: 0 <= i < |b| ==> (b[i] == '0' || b[i] == '1')
    ensures |result| == |a|
    ensures forall i :: 0 <= i < |result| ==> (result[i] == '0' || result[i] == '1')
    ensures forall i :: 0 <= i < |result| ==> 
        (result[i] == '0' <==> a[i] == b[i])
{
    result := "";
    var i := 0;
    while i < |a|
        invariant 0 <= i <= |a|
        invariant |result| == i
        invariant forall j :: 0 <= j < i ==> (result[j] == '0' || result[j] == '1')
        invariant forall j :: 0 <= j < i ==> (result[j] == '0' <==> a[j] == b[j])
        decreases |a| - i
    {
        if a[i] == b[i] {
            result := result + "0";
        } else {
            result := result + "1";
        }
        i := i + 1;
    }
}