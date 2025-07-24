method mean_absolute_deviation(numbers: seq<real>) returns (result: real)
    requires |numbers| > 0
    ensures result >= 0.0
{
    result := 0.0;
}

method abs_real(x: real) returns (result: real)
    ensures result >= 0.0
    ensures result == x || result == -x
{
    if x >= 0.0 {
        result := x;
    } else {
        result := -x;
    }
}

method {:test} test_0()
{
    var result := mean_absolute_deviation([1.0, 2.0, 3.0]);
    var expected := 2.0/3.0;
    var diff := abs_real(result - expected);
    expect diff < 0.000001;
}

method {:test} test_1()
{
    var result := mean_absolute_deviation([1.0, 2.0, 3.0, 4.0]);
    var expected := 1.0;
    var diff := abs_real(result - expected);
    expect diff < 0.000001;
}

method {:test} test_2()
{
    var result := mean_absolute_deviation([1.0, 2.0, 3.0, 4.0, 5.0]);
    var expected := 6.0/5.0;
    var diff := abs_real(result - expected);
    expect diff < 0.000001;
}