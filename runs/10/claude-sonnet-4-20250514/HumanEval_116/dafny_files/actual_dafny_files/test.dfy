method sort_array(arr: seq<int>) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := sort_array([1,5,2,3,4]);
    expect result == [1, 2, 4, 3, 5];
}

method {:test} test_1()
{
    var result := sort_array([-2,-3,-4,-5,-6]);
    expect result == [-4, -2, -6, -5, -3]; 
}

method {:test} test_2()
{
    var result := sort_array([1,0,2,3,4]);
    expect result == [0, 1, 2, 4, 3];
}

method {:test} test_3()
{
    var result := sort_array([]);
    expect result == [];
}

method {:test} test_4()
{
    var result := sort_array([2,5,77,4,5,3,5,7,2,3,4]);
    expect result == [2, 2, 4, 4, 3, 3, 5, 5, 5, 7, 77];
}

method {:test} test_5()
{
    var result := sort_array([3,6,44,12,32,5]);
    expect result == [32, 3, 5, 6, 12, 44];
}

method {:test} test_6()
{
    var result := sort_array([2,4,8,16,32]);
    expect result == [2, 4, 8, 16, 32];
}

method {:test} test_7()
{
    var result := sort_array([2,4,8,16,32]);
    expect result == [2, 4, 8, 16, 32];
}