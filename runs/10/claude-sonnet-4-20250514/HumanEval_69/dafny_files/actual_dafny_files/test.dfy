method search(lst: seq<int>) returns (result: int)
    requires |lst| > 0
    requires forall i :: 0 <= i < |lst| ==> lst[i] > 0
{
    result := -1;
}

method {:test} test_0()
{
    var result := search([5, 5, 5, 5, 1]);
    expect result == 1;
}

method {:test} test_1()
{
    var result := search([4, 1, 4, 1, 4, 4]);
    expect result == 4;
}

method {:test} test_2()
{
    var result := search([3, 3]);
    expect result == -1;
}

method {:test} test_3()
{
    var result := search([8, 8, 8, 8, 8, 8, 8, 8]);
    expect result == 8;
}

method {:test} test_4()
{
    var result := search([2, 3, 3, 2, 2]);
    expect result == 2;
}

method {:test} test_5()
{
    var result := search([2, 7, 8, 8, 4, 8, 7, 3, 9, 6, 5, 10, 4, 3, 6, 7, 1, 7, 4, 10, 8, 1]);
    expect result == 1;
}

method {:test} test_6()
{
    var result := search([3, 2, 8, 2]);
    expect result == 2;
}

method {:test} test_7()
{
    var result := search([6, 7, 1, 8, 8, 10, 5, 8, 5, 3, 10]);
    expect result == 1;
}

method {:test} test_8()
{
    var result := search([8, 8, 3, 6, 5, 6, 4]);
    expect result == -1;
}

method {:test} test_9()
{
    var result := search([6, 9, 6, 7, 1, 4, 7, 1, 8, 8, 9, 8, 10, 10, 8, 4, 10, 4, 10, 1, 2, 9, 5, 7, 9]);
    expect result == 1;
}

method {:test} test_10()
{
    var result := search([1, 9, 10, 1, 3]);
    expect result == 1;
}

method {:test} test_11()
{
    var result := search([6, 9, 7, 5, 8, 7, 5, 3, 7, 5, 10, 10, 3, 6, 10, 2, 8, 6, 5, 4, 9, 5, 3, 10]);
    expect result == 5;
}

method {:test} test_12()
{
    var result := search([1]);
    expect result == 1;
}

method {:test} test_13()
{
    var result := search([8, 8, 10, 6, 4, 3, 5, 8, 2, 4, 2, 8, 4, 6, 10, 4, 2, 1, 10, 2, 1, 1, 5]);
    expect result == 4;
}

method {:test} test_14()
{
    var result := search([2, 10, 4, 8, 2, 10, 5, 1, 2, 9, 5, 5, 6, 3, 8, 6, 4, 10]);
    expect result == 2;
}

method {:test} test_15()
{
    var result := search([1, 6, 10, 1, 6, 9, 10, 8, 6, 8, 7, 3]);
    expect result == 1;
}

method {:test} test_16()
{
    var result := search([9, 2, 4, 1, 5, 1, 5, 2, 5, 7, 7, 7, 3, 10, 1, 5, 4, 2, 8, 4, 1, 9, 10, 7, 10, 2, 8, 10, 9, 4]);
    expect result == 4;
}

method {:test} test_17()
{
    var result := search([2, 6, 4, 2, 8, 7, 5, 6, 4, 10, 4, 6, 3, 7, 8, 8, 3, 1, 4, 2, 2, 10, 7]);
    expect result == 4;
}

method {:test} test_18()
{
    var result := search([9, 8, 6, 10, 2, 6, 10, 2, 7, 8, 10, 3, 8, 2, 6, 2, 3, 1]);
    expect result == 2;
}

method {:test} test_19()
{
    var result := search([5, 5, 3, 9, 5, 6, 3, 2, 8, 5, 6, 10, 10, 6, 8, 4, 10, 7, 7, 10, 8]);
    expect result == -1;
}

method {:test} test_20()
{
    var result := search([10]);
    expect result == -1;
}

method {:test} test_21()
{
    var result := search([9, 7, 7, 2, 4, 7, 2, 10, 9, 7, 5, 7, 2]);
    expect result == 2;
}

method {:test} test_22()
{
    var result := search([5, 4, 10, 2, 1, 1, 10, 3, 6, 1, 8]);
    expect result == 1;
}

method {:test} test_23()
{
    var result := search([7, 9, 9, 9, 3, 4, 1, 5, 9, 1, 2, 1, 1, 10, 7, 5, 6, 7, 6, 7, 7, 6]);
    expect result == 1;
}

method {:test} test_24()
{
    var result := search([3, 10, 10, 9, 2]);
    expect result == -1;
}