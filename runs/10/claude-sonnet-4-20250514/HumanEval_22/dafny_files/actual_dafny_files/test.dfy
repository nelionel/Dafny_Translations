datatype Value = IntValue(i: int) | RealValue(r: real) | StringValue(s: string) | BoolValue(b: bool)

method filter_integers(values: seq<Value>) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := filter_integers([]);
    expect result == [];
}

method {:test} test_1()
{
    var input := [IntValue(4), BoolValue(false), BoolValue(false), RealValue(23.2), IntValue(9), StringValue("adasd")];
    var result := filter_integers(input);
    expect result == [4, 9];
}

method {:test} test_2()
{
    var input := [IntValue(3), StringValue("c"), IntValue(3), IntValue(3), StringValue("a"), StringValue("b")];
    var result := filter_integers(input);
    expect result == [3, 3, 3];
}