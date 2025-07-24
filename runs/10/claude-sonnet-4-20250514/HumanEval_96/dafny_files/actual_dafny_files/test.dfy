method count_up_to(n: int) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := count_up_to(5);
    expect result == [2,3];
}

method {:test} test_1()
{
    var result := count_up_to(6);
    expect result == [2,3,5];
}

method {:test} test_2()
{
    var result := count_up_to(7);
    expect result == [2,3,5];
}

method {:test} test_3()
{
    var result := count_up_to(10);
    expect result == [2,3,5,7];
}

method {:test} test_4()
{
    var result := count_up_to(0);
    expect result == [];
}

method {:test} test_5()
{
    var result := count_up_to(22);
    expect result == [2,3,5,7,11,13,17,19];
}

method {:test} test_6()
{
    var result := count_up_to(1);
    expect result == [];
}

method {:test} test_7()
{
    var result := count_up_to(18);
    expect result == [2,3,5,7,11,13,17];
}

method {:test} test_8()
{
    var result := count_up_to(47);
    expect result == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43];
}

method {:test} test_9()
{
    var result := count_up_to(101);
    expect result == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97];
}