method decode_shift(s: string) returns (result: string)
  requires forall i :: 0 <= i < |s| ==> 'a' <= s[i] <= 'z'
  ensures |result| == |s|
  ensures forall i :: 0 <= i < |result| ==> 'a' <= result[i] <= 'z'
{
    result := "";
}

method {:test} test_0()
{
    var result := decode_shift("fgh");
    expect result == "abc";
}

method {:test} test_1()
{
    var result := decode_shift("f");
    expect result == "a";
}

method {:test} test_2()
{
    var result := decode_shift("edcba");
    expect result == "zyxwv";
}

method {:test} test_3()
{
    var result := decode_shift("nopqr");
    expect result == "ijklm";
}

method {:test} test_4()
{
    var result := decode_shift("");
    expect result == "";
}

method {:test} test_5()
{
    var result := decode_shift("ujqqt");
    expect result == "hello";
}

method {:test} test_6()
{
    var result := decode_shift("btwqi");
    expect result == "world";
}