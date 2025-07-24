method get_closest_vowel(word: string) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := get_closest_vowel("yogurt");
    expect result == "u";
}

method {:test} test_1()
{
    var result := get_closest_vowel("full");
    expect result == "u";
}

method {:test} test_2()
{
    var result := get_closest_vowel("easy");
    expect result == "";
}

method {:test} test_3()
{
    var result := get_closest_vowel("eAsy");
    expect result == "";
}

method {:test} test_4()
{
    var result := get_closest_vowel("ali");
    expect result == "";
}

method {:test} test_5()
{
    var result := get_closest_vowel("bad");
    expect result == "a";
}

method {:test} test_6()
{
    var result := get_closest_vowel("most");
    expect result == "o";
}

method {:test} test_7()
{
    var result := get_closest_vowel("ab");
    expect result == "";
}

method {:test} test_8()
{
    var result := get_closest_vowel("ba");
    expect result == "";
}

method {:test} test_9()
{
    var result := get_closest_vowel("quick");
    expect result == "";
}

method {:test} test_10()
{
    var result := get_closest_vowel("anime");
    expect result == "i";
}

method {:test} test_11()
{
    var result := get_closest_vowel("Asia");
    expect result == "";
}

method {:test} test_12()
{
    var result := get_closest_vowel("Above");
    expect result == "o";
}