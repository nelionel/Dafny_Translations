function ceiling(x: real): int
{
    var floor_x := x.Floor;
    if x == floor_x as real then floor_x else floor_x + 1
}

method sum_squares(lst: seq<real>) returns (result: int)
    ensures result >= 0
{
    result := 0;
    var i := 0;
    
    while i < |lst|
        invariant 0 <= i <= |lst|
        invariant result >= 0
        decreases |lst| - i
    {
        var ceiling_num := ceiling(lst[i]);
        result := result + ceiling_num * ceiling_num;
        i := i + 1;
    }
}