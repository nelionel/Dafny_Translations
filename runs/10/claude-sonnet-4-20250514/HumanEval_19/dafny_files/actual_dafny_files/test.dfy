method sort_numbers(numbers: string) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := sort_numbers("");
    expect result == "";
}

method {:test} test_1()
{
    var result := sort_numbers("three");
    expect result == "three";
}

method {:test} test_2()
{
    var result := sort_numbers("three five nine");
    expect result == "three five nine";
}

method {:test} test_3()
{
    var result := sort_numbers("five zero four seven nine eight");
    expect result == "zero four five seven eight nine";
}

method {:test} test_4()
{
    var result := sort_numbers("six five four three two one zero");
    expect result == "zero one two three four five six";
}