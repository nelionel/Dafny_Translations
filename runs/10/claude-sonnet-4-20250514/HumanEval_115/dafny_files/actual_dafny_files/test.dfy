method max_fill(grid: seq<seq<int>>, capacity: int) returns (total_trips: int)
    requires capacity > 0
    requires |grid| > 0
    requires forall i :: 0 <= i < |grid| ==> |grid[i]| > 0
    requires forall i, j :: 0 <= i < |grid| && 0 <= j < |grid[i]| ==> grid[i][j] == 0 || grid[i][j] == 1
    requires forall i :: 0 <= i < |grid| - 1 ==> |grid[i]| == |grid[i + 1]|
    ensures total_trips >= 0
{
    total_trips := 0;
}

method {:test} test_0()
{
    var result := max_fill([[0,0,1,0], [0,1,0,0], [1,1,1,1]], 1);
    expect result == 6;
}

method {:test} test_1()
{
    var result := max_fill([[0,0,1,1], [0,0,0,0], [1,1,1,1], [0,1,1,1]], 2);
    expect result == 5;
}

method {:test} test_2()
{
    var result := max_fill([[0,0,0], [0,0,0]], 5);
    expect result == 0;
}

method {:test} test_3()
{
    var result := max_fill([[1,1,1,1], [1,1,1,1]], 2);
    expect result == 4;
}

method {:test} test_4()
{
    var result := max_fill([[1,1,1,1], [1,1,1,1]], 9);
    expect result == 2;
}