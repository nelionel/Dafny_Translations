method words_in_sentence(sentence: string) returns (result: string)
  requires |sentence| >= 1 && |sentence| <= 100
  ensures |result| <= |sentence|
{
    result := "";
}

method {:test} test_0()
{
    var result := words_in_sentence("This is a test");
    expect result == "is";
}

method {:test} test_1()
{
    var result := words_in_sentence("lets go for swimming");
    expect result == "go for";
}

method {:test} test_2()
{
    var result := words_in_sentence("there is no place available here");
    expect result == "there is no place";
}

method {:test} test_3()
{
    var result := words_in_sentence("Hi I am Hussein");
    expect result == "Hi am Hussein";
}

method {:test} test_4()
{
    var result := words_in_sentence("go for it");
    expect result == "go for it";
}

method {:test} test_5()
{
    var result := words_in_sentence("here");
    expect result == "";
}

method {:test} test_6()
{
    var result := words_in_sentence("here is");
    expect result == "is";
}