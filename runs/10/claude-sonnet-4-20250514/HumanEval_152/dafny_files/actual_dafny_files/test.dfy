method compare(game: seq<int>, guess: seq<int>) returns (result: seq<int>)
    requires |game| == |guess|
    ensures |result| == |game|
{
    result := [];
}

function abs(x: int): int
{
    if x >= 0 then x else -x
}

method {:test} test_0()
{
    var result := compare([1,2,3,4,5,1], [1,2,3,4,2,-2]);
    expect result == [0,0,0,0,3,3];
}

method {:test} test_1()
{
    var result := compare([0,0,0,0,0,0], [0,0,0,0,0,0]);
    expect result == [0,0,0,0,0,0];
}

method {:test} test_2()
{
    var result := compare([1,2,3], [-1,-2,-3]);
    expect result == [2,4,6];
}

method {:test} test_3()
{
    var result := compare([1,2,3,5], [-1,2,3,4]);
    expect result == [2,0,0,1];
}

method {:test} test_4()
{
    // This corresponds to "assert True" - always passes
    expect true;
}