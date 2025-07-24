method derivative(xs: seq<real>) returns (result: seq<real>)
{
    result := [];
}

method {:test} test_0()
{
    var result := derivative([3.0, 1.0, 2.0, 4.0, 5.0]);
    expect result == [1.0, 4.0, 12.0, 20.0];
}

method {:test} test_1()
{
    var result := derivative([1.0, 2.0, 3.0]);
    expect result == [2.0, 6.0];
}

method {:test} test_2()
{
    var result := derivative([3.0, 2.0, 1.0]);
    expect result == [2.0, 2.0];
}

method {:test} test_3()
{
    var result := derivative([3.0, 2.0, 1.0, 0.0, 4.0]);
    expect result == [2.0, 2.0, 0.0, 16.0];
}

method {:test} test_4()
{
    var result := derivative([1.0]);
    expect result == [];
}