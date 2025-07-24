method compare_one(a: string, b: string) returns (result: string)
  requires |a| > 0 && |b| > 0
  ensures result == "" || result == a || result == b
{
  result := "";
}

method string_to_real(s: string) returns (r: real)
  requires |s| > 0
{
  r := 0.0;
}

method normalize_decimal_separator(s: string) returns (normalized: string)
  requires |s| > 0
  ensures |normalized| == |s|
{
  normalized := s;
}

method parse_decimal_string(s: string) returns (r: real)
  requires |s| > 0
{
  r := 0.0;
}

method {:test} test_0()
{
    var result := compare_one("1", "2");
    expect result == "2";
}

method {:test} test_1()
{
    var result := compare_one("1", "2.5");
    expect result == "2.5";
}

method {:test} test_2()
{
    var result := compare_one("2", "3");
    expect result == "3";
}

method {:test} test_3()
{
    var result := compare_one("5", "6");
    expect result == "6";
}

method {:test} test_4()
{
    var result := compare_one("1", "2,3");
    expect result == "2,3";
}

method {:test} test_5()
{
    var result := compare_one("5,1", "6");
    expect result == "6";
}

method {:test} test_6()
{
    var result := compare_one("1", "2");
    expect result == "2";
}