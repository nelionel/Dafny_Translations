method even_odd_palindrome(n: int) returns (result: seq<int>)
    requires n >= 1
    ensures |result| == 2
    ensures result[0] >= 0 && result[1] >= 0
{
    result := [0, 0];
}

method {:test} test_0()
{
    var result := even_odd_palindrome(123);
    expect result == [8, 13];
}

method {:test} test_1()
{
    var result := even_odd_palindrome(12);
    expect result == [4, 6];
}

method {:test} test_2()
{
    var result := even_odd_palindrome(3);
    expect result == [1, 2];
}

method {:test} test_3()
{
    var result := even_odd_palindrome(63);
    expect result == [6, 8];
}

method {:test} test_4()
{
    var result := even_odd_palindrome(25);
    expect result == [5, 6];
}

method {:test} test_5()
{
    var result := even_odd_palindrome(19);
    expect result == [4, 6];
}

method {:test} test_6()
{
    var result := even_odd_palindrome(9);
    expect result == [4, 5];
}

method {:test} test_7()
{
    var result := even_odd_palindrome(1);
    expect result == [0, 1];
}