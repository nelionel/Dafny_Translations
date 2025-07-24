method match_parens(lst: seq<string>) returns (result: string)
    requires |lst| == 2
    requires forall i :: 0 <= i < |lst| ==> forall j :: 0 <= j < |lst[i]| ==> lst[i][j] == '(' || lst[i][j] == ')'
    ensures result == "Yes" || result == "No"
{
    result := "No";
}

method {:test} test_0()
{
    var result := match_parens(["()(", ")"]);
    expect result == "Yes";
}

method {:test} test_1()
{
    var result := match_parens([")", ")"]);
    expect result == "No";
}

method {:test} test_2()
{
    var result := match_parens(["(()(())", "())())"]);
    expect result == "No";
}

method {:test} test_3()
{
    var result := match_parens([")())", "(()()(""]);
    expect result == "Yes";
}

method {:test} test_4()
{
    var result := match_parens(["(())))", "(()())(("]);
    expect result == "Yes";
}

method {:test} test_5()
{
    var result := match_parens(["()", "())"]);
    expect result == "No";
}

method {:test} test_6()
{
    var result := match_parens(["(()(", "()))()""]);
    expect result == "Yes";
}

method {:test} test_7()
{
    var result := match_parens(["((((", "((())"]);
    expect result == "No";
}

method {:test} test_8()
{
    var result := match_parens([")(()", "(()(""]);
    expect result == "No";
}

method {:test} test_9()
{
    var result := match_parens([")(", ")("]);
    expect result == "No";
}

method {:test} test_10()
{
    var result := match_parens(["(", ")"]);
    expect result == "Yes";
}

method {:test} test_11()
{
    var result := match_parens([")", "("]);
    expect result == "Yes";
}