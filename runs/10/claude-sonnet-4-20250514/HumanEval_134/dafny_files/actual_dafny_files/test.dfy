predicate IsAlpha(c: char)
{
    false
}

method check_if_last_char_is_a_letter(txt: string) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := check_if_last_char_is_a_letter("apple");
    expect result == false;
}

method {:test} test_1()
{
    var result := check_if_last_char_is_a_letter("apple pi e");
    expect result == true;
}

method {:test} test_2()
{
    var result := check_if_last_char_is_a_letter("eeeee");
    expect result == false;
}

method {:test} test_3()
{
    var result := check_if_last_char_is_a_letter("A");
    expect result == true;
}

method {:test} test_4()
{
    var result := check_if_last_char_is_a_letter("Pumpkin pie ");
    expect result == false;
}

method {:test} test_5()
{
    var result := check_if_last_char_is_a_letter("Pumpkin pie 1");
    expect result == false;
}

method {:test} test_6()
{
    var result := check_if_last_char_is_a_letter("");
    expect result == false;
}

method {:test} test_7()
{
    var result := check_if_last_char_is_a_letter("eeeee e ");
    expect result == false;
}

method {:test} test_8()
{
    var result := check_if_last_char_is_a_letter("apple pie");
    expect result == false;
}

method {:test} test_9()
{
    var result := check_if_last_char_is_a_letter("apple pi e ");
    expect result == false;
}