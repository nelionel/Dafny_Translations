method solve(s: string) returns (result: string)
{
    result := "";
}

function IsAlpha(c: char): bool
{
    false
}

function IsLower(c: char): bool
  requires IsAlpha(c)
{
    false
}

function ToUpper(c: char): char
  requires IsAlpha(c) && IsLower(c)
  ensures IsAlpha(ToUpper(c)) && !IsLower(ToUpper(c))
{
    'A'
}

function ToLower(c: char): char
  requires IsAlpha(c) && !IsLower(c)
  ensures IsAlpha(ToLower(c)) && IsLower(ToLower(c))
{
    'a'
}

function HasLetters(s: string): bool
{
    false
}

function ReverseString(s: string): string
  ensures |ReverseString(s)| == |s|
  ensures forall i :: 0 <= i < |s| ==> ReverseString(s)[i] == s[|s| - 1 - i]
{
    ""
}

method {:test} test_0()
{
    var result := solve("AsDf");
    expect result == "aSdF";
}

method {:test} test_1()
{
    var result := solve("1234");
    expect result == "4321";
}

method {:test} test_2()
{
    var result := solve("ab");
    expect result == "AB";
}

method {:test} test_3()
{
    var result := solve("#a@C");
    expect result == "#A@c";
}

method {:test} test_4()
{
    var result := solve("#AsdfW^45");
    expect result == "#aSDFw^45";
}

method {:test} test_5()
{
    var result := solve("#6@2");
    expect result == "2@6#";
}

method {:test} test_6()
{
    var result := solve("#$a^D");
    expect result == "#$A^d";
}

method {:test} test_7()
{
    var result := solve("#ccc");
    expect result == "#CCC";
}