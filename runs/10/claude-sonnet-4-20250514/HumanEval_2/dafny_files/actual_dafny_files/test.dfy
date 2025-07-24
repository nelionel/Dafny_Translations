method truncate_number(number: real) returns (result: real)
{
    result := 0.0;
}

method {:test} test_0()
{
    var result := truncate_number(3.5);
    expect result == 0.5;
}

method {:test} test_1()
{
    var result := truncate_number(1.33);
    var diff := result - 0.33;
    var abs_diff := if diff >= 0.0 then diff else -diff;
    expect abs_diff < 0.000001;
}

method {:test} test_2()
{
    var result := truncate_number(123.456);
    var diff := result - 0.456;
    var abs_diff := if diff >= 0.0 then diff else -diff;
    expect abs_diff < 0.000001;
}