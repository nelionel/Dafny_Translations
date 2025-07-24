method Strongest_Extension(class_name: string, extensions: seq<string>) returns (result: string)
  requires |extensions| > 0
  ensures |result| > 0
  ensures exists i :: 0 <= i < |extensions| && class_name + "." + extensions[i] == result
{
    result := class_name + "." + extensions[0];
}

function CalculateStrength(extension: string): int
{
    0
}

function CountUppercase(s: string): int
{
    0
}

function CountLowercase(s: string): int
{
    0
}

method {:test} test_0()
{
    var result := Strongest_Extension("Watashi", ["tEN", "niNE", "eIGHt8OKe"]);
    expect result == "Watashi.eIGHt8OKe";
}

method {:test} test_1()
{
    var result := Strongest_Extension("Boku123", ["nani", "NazeDa", "YEs.WeCaNe", "32145tggg"]);
    expect result == "Boku123.YEs.WeCaNe";
}

method {:test} test_2()
{
    var result := Strongest_Extension("__YESIMHERE", ["t", "eMptY", "nothing", "zeR00", "NuLl__", "123NoooneB321"]);
    expect result == "__YESIMHERE.NuLl__";
}

method {:test} test_3()
{
    var result := Strongest_Extension("K", ["Ta", "TAR", "t234An", "cosSo"]);
    expect result == "K.TAR";
}

method {:test} test_4()
{
    var result := Strongest_Extension("__HAHA", ["Tab", "123", "781345", "-_-"]);
    expect result == "__HAHA.123";
}

method {:test} test_5()
{
    var result := Strongest_Extension("YameRore", ["HhAas", "okIWILL123", "WorkOut", "Fails", "-_-"]);
    expect result == "YameRore.okIWILL123";
}

method {:test} test_6()
{
    var result := Strongest_Extension("finNNalLLly", ["Die", "NowW", "Wow", "WoW"]);
    expect result == "finNNalLLly.WoW";
}

method {:test} test_7()
{
    var result := Strongest_Extension("_", ["Bb", "91245"]);
    expect result == "_.Bb";
}

method {:test} test_8()
{
    var result := Strongest_Extension("Sp", ["671235", "Bb"]);
    expect result == "Sp.671235";
}