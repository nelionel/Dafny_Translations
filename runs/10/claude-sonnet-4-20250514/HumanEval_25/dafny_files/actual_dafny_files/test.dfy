method factorize(n: int) returns (factors: seq<int>)
    requires n >= 0
    ensures n <= 1 ==> |factors| == 0
    ensures n > 1 ==> |factors| > 0
    ensures forall i :: 0 <= i < |factors| - 1 ==> factors[i] <= factors[i + 1]
{
    factors := [];
}

method {:test} test_0()
{
    var result := factorize(2);
    expect result == [2];
}

method {:test} test_1()
{
    var result := factorize(4);
    expect result == [2, 2];
}

method {:test} test_2()
{
    var result := factorize(8);
    expect result == [2, 2, 2];
}

method {:test} test_3()
{
    var result := factorize(57);
    expect result == [3, 19];
}

method {:test} test_4()
{
    var result := factorize(3249);
    expect result == [3, 3, 19, 19];
}

method {:test} test_5()
{
    var result := factorize(185193);
    expect result == [3, 3, 3, 19, 19, 19];
}

method {:test} test_6()
{
    var result := factorize(20577);
    expect result == [3, 19, 19, 19];
}

method {:test} test_7()
{
    var result := factorize(18);
    expect result == [2, 3, 3];
}