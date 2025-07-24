method largest_smallest_integers(lst: seq<int>) returns (result: seq<int>)
  ensures |result| == 4
  ensures result[0] == 0 || result[0] == 1  
  ensures result[2] == 0 || result[2] == 1  
  ensures result[0] == 1 ==> result[1] < 0   
  ensures result[2] == 1 ==> result[3] > 0   
  ensures result[0] == 1 ==> (exists i :: 0 <= i < |lst| && lst[i] == result[1] && lst[i] < 0)
  ensures result[2] == 1 ==> (exists i :: 0 <= i < |lst| && lst[i] == result[3] && lst[i] > 0)
  ensures result[0] == 1 ==> (forall i :: 0 <= i < |lst| && lst[i] < 0 ==> lst[i] <= result[1])
  ensures result[2] == 1 ==> (forall i :: 0 <= i < |lst| && lst[i] > 0 ==> lst[i] >= result[3])
{
  result := [0, 0, 0, 0];
}

method {:test} test_0()
{
    var result := largest_smallest_integers([2, 4, 1, 3, 5, 7]);
    expect result == [0, 0, 1, 1];
}

method {:test} test_1()
{
    var result := largest_smallest_integers([2, 4, 1, 3, 5, 7, 0]);
    expect result == [0, 0, 1, 1];
}

method {:test} test_2()
{
    var result := largest_smallest_integers([1, 3, 2, 4, 5, 6, -2]);
    expect result == [1, -2, 1, 1];
}

method {:test} test_3()
{
    var result := largest_smallest_integers([4, 5, 3, 6, 2, 7, -7]);
    expect result == [1, -7, 1, 2];
}

method {:test} test_4()
{
    var result := largest_smallest_integers([7, 3, 8, 4, 9, 2, 5, -9]);
    expect result == [1, -9, 1, 2];
}

method {:test} test_5()
{
    var result := largest_smallest_integers([]);
    expect result == [0, 0, 0, 0];
}

method {:test} test_6()
{
    var result := largest_smallest_integers([0]);
    expect result == [0, 0, 0, 0];
}

method {:test} test_7()
{
    var result := largest_smallest_integers([-1, -3, -5, -6]);
    expect result == [1, -1, 0, 0];
}

method {:test} test_8()
{
    var result := largest_smallest_integers([-1, -3, -5, -6, 0]);
    expect result == [1, -1, 0, 0];
}

method {:test} test_9()
{
    var result := largest_smallest_integers([-6, -4, -4, -3, 1]);
    expect result == [1, -3, 1, 1];
}

method {:test} test_10()
{
    var result := largest_smallest_integers([-6, -4, -4, -3, -100, 1]);
    expect result == [1, -3, 1, 1];
}