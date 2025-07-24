method reverse_delete(s: string, c: string) returns (result: string, is_palindrome: bool)
{
    result := "";
    is_palindrome := false;
}

function reverse_string(str: string): string
{
    ""
}

method {:test} test_0()
{
    var result, is_palindrome := reverse_delete("abcde", "ae");
    expect result == "bcd" && is_palindrome == false;
}

method {:test} test_1()
{
    var result, is_palindrome := reverse_delete("abcdef", "b");
    expect result == "acdef" && is_palindrome == false;
}

method {:test} test_2()
{
    var result, is_palindrome := reverse_delete("abcdedcba", "ab");
    expect result == "cdedc" && is_palindrome == true;
}

method {:test} test_3()
{
    var result, is_palindrome := reverse_delete("dwik", "w");
    expect result == "dik" && is_palindrome == false;
}

method {:test} test_4()
{
    var result, is_palindrome := reverse_delete("a", "a");
    expect result == "" && is_palindrome == true;
}

method {:test} test_5()
{
    var result, is_palindrome := reverse_delete("abcdedcba", "");
    expect result == "abcdedcba" && is_palindrome == true;
}

method {:test} test_6()
{
    var result, is_palindrome := reverse_delete("abcdedcba", "v");
    expect result == "abcdedcba" && is_palindrome == true;
}

method {:test} test_7()
{
    var result, is_palindrome := reverse_delete("vabba", "v");
    expect result == "abba" && is_palindrome == true;
}

method {:test} test_8()
{
    var result, is_palindrome := reverse_delete("mamma", "mia");
    expect result == "" && is_palindrome == true;
}