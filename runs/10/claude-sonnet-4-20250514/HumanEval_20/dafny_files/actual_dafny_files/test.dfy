function abs(x: real): real
{
  0.0
}

method find_closest_elements(numbers: seq<real>) returns (result: seq<real>)
{
  result := [0.0, 0.0];
}

method {:test} test_0()
{
    var result := find_closest_elements([1.0, 2.0, 3.9, 4.0, 5.0, 2.2]);
    expect result == [3.9, 4.0];
}

method {:test} test_1()
{
    var result := find_closest_elements([1.0, 2.0, 5.9, 4.0, 5.0]);
    expect result == [5.0, 5.9];
}

method {:test} test_2()
{
    var result := find_closest_elements([1.0, 2.0, 3.0, 4.0, 5.0, 2.2]);
    expect result == [2.0, 2.2];
}

method {:test} test_3()
{
    var result := find_closest_elements([1.0, 2.0, 3.0, 4.0, 5.0, 2.0]);
    expect result == [2.0, 2.0];
}

method {:test} test_4()
{
    var result := find_closest_elements([1.1, 2.2, 3.1, 4.1, 5.1]);
    expect result == [2.2, 3.1];
}