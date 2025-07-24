method get_max_triples(n: int) returns (result: int)
    requires n > 0
    ensures result >= 0
{
    result := 0;
}

method {:test} test_0()
{
    var result := get_max_triples(5);
    expect result == 1;
}

method {:test} test_1()
{
    var result := get_max_triples(6);
    expect result == 4;
}

method {:test} test_2()
{
    var result := get_max_triples(10);
    expect result == 36;
}

method {:test} test_3()
{
    var result := get_max_triples(100);
    expect result == 53361;
}