method rescale_to_unit(numbers: seq<real>) returns (result: seq<real>)
{
    result := [];
}

method {:test} test_0()
{
    var result := rescale_to_unit([2.0, 49.9]);
    expect result == [0.0, 1.0];
}

method {:test} test_1()
{
    var result := rescale_to_unit([100.0, 49.9]);
    expect result == [1.0, 0.0];
}

method {:test} test_2()
{
    var result := rescale_to_unit([1.0, 2.0, 3.0, 4.0, 5.0]);
    expect result == [0.0, 0.25, 0.5, 0.75, 1.0];
}

method {:test} test_3()
{
    var result := rescale_to_unit([2.0, 1.0, 5.0, 3.0, 4.0]);
    expect result == [0.25, 0.0, 1.0, 0.5, 0.75];
}

method {:test} test_4()
{
    var result := rescale_to_unit([12.0, 11.0, 15.0, 13.0, 14.0]);
    expect result == [0.25, 0.0, 1.0, 0.5, 0.75];
}