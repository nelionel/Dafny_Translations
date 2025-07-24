method compare(game: seq<int>, guess: seq<int>) returns (result: seq<int>)
    requires |game| == |guess|
    ensures |result| == |game|
    ensures forall i :: 0 <= i < |result| ==> result[i] == abs(game[i] - guess[i])
    ensures forall i :: 0 <= i < |result| ==> result[i] >= 0
{
    result := [];
    var i := 0;
    
    while i < |game|
        invariant 0 <= i <= |game|
        invariant |result| == i
        invariant forall j :: 0 <= j < i ==> result[j] == abs(game[j] - guess[j])
        invariant forall j :: 0 <= j < i ==> result[j] >= 0
        decreases |game| - i
    {
        var difference := abs(game[i] - guess[i]);
        result := result + [difference];
        i := i + 1;
    }
}

function abs(x: int): int
    ensures abs(x) >= 0
    ensures abs(x) == x || abs(x) == -x
    ensures x >= 0 ==> abs(x) == x
    ensures x < 0 ==> abs(x) == -x
{
    if x >= 0 then x else -x
}