method histogram(test: string) returns (result: seq<(string, int)>)
    ensures |result| >= 0
    ensures forall i, j :: 0 <= i < |result| && 0 <= j < |result| ==> result[i].1 == result[j].1
{
    result := [];
}

method {:test} test_0()
{
    var result := histogram("a b b a");
    expect |result| == 2;
    expect (("a", 2) in result) && (("b", 2) in result);
}

method {:test} test_1()
{
    var result := histogram("a b c a b");
    expect |result| == 2;
    expect (("a", 2) in result) && (("b", 2) in result);
}

method {:test} test_2()
{
    var result := histogram("a b c d g");
    expect |result| == 5;
    expect (("a", 1) in result) && (("b", 1) in result) && (("c", 1) in result) && (("d", 1) in result) && (("g", 1) in result);
}

method {:test} test_3()
{
    var result := histogram("r t g");
    expect |result| == 3;
    expect (("r", 1) in result) && (("t", 1) in result) && (("g", 1) in result);
}

method {:test} test_4()
{
    var result := histogram("b b b b a");
    expect |result| == 1;
    expect ("b", 4) in result;
}

method {:test} test_5()
{
    var result := histogram("r t g");
    expect |result| == 3;
    expect (("r", 1) in result) && (("t", 1) in result) && (("g", 1) in result);
}

method {:test} test_6()
{
    var result := histogram("");
    expect result == [];
}

method {:test} test_7()
{
    var result := histogram("a");
    expect |result| == 1;
    expect ("a", 1) in result;
}