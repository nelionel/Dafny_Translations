method double_the_difference(lst: seq<real>) returns (result: int)
  ensures result >= 0
{
    return 0;
}

method {:test} test_0()
{
    var result := double_the_difference([]);
    expect result == 0;
}

method {:test} test_1()
{
    var result := double_the_difference([5.0, 4.0]);
    expect result == 25;
}

method {:test} test_2()
{
    var result := double_the_difference([0.1, 0.2, 0.3]);
    expect result == 0;
}

method {:test} test_3()
{
    var result := double_the_difference([-10.0, -20.0, -30.0]);
    expect result == 0;
}

method {:test} test_4()
{
    var result := double_the_difference([-1.0, -2.0, 8.0]);
    expect result == 0;
}

method {:test} test_5()
{
    var result := double_the_difference([0.2, 3.0, 5.0]);
    expect result == 34;
}

method {:test} test_6()
{
    // This test corresponds to the complex case with range(-99, 100, 2)
    // which creates [-99, -97, -95, ..., 95, 97, 99]
    // The sum of squares of positive odd numbers in this range is:
    // 1^2 + 3^2 + 5^2 + ... + 97^2 + 99^2 = 166650
    var lst := [-99.0, -97.0, -95.0, -93.0, -91.0, -89.0, -87.0, -85.0, -83.0, -81.0,
                -79.0, -77.0, -75.0, -73.0, -71.0, -69.0, -67.0, -65.0, -63.0, -61.0,
                -59.0, -57.0, -55.0, -53.0, -51.0, -49.0, -47.0, -45.0, -43.0, -41.0,
                -39.0, -37.0, -35.0, -33.0, -31.0, -29.0, -27.0, -25.0, -23.0, -21.0,
                -19.0, -17.0, -15.0, -13.0, -11.0, -9.0, -7.0, -5.0, -3.0, -1.0,
                1.0, 3.0, 5.0, 7.0, 9.0, 11.0, 13.0, 15.0, 17.0, 19.0,
                21.0, 23.0, 25.0, 27.0, 29.0, 31.0, 33.0, 35.0, 37.0, 39.0,
                41.0, 43.0, 45.0, 47.0, 49.0, 51.0, 53.0, 55.0, 57.0, 59.0,
                61.0, 63.0, 65.0, 67.0, 69.0, 71.0, 73.0, 75.0, 77.0, 79.0,
                81.0, 83.0, 85.0, 87.0, 89.0, 91.0, 93.0, 95.0, 97.0, 99.0];
    var result := double_the_difference(lst);
    expect result == 166650;
}