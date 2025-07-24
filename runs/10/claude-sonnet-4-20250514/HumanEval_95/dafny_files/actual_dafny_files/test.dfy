method check_dict_case(dict: map<string, string>) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := check_dict_case(map["p" := "pineapple", "b" := "banana"]);
    expect result == true;
}

method {:test} test_1()
{
    var result := check_dict_case(map["p" := "pineapple", "A" := "banana", "B" := "banana"]);
    expect result == false;
}

method {:test} test_2()
{
    var result := check_dict_case(map["p" := "pineapple", "5" := "banana", "a" := "apple"]);
    expect result == false;
}

method {:test} test_3()
{
    var result := check_dict_case(map["Name" := "John", "Age" := "36", "City" := "Houston"]);
    expect result == false;
}

method {:test} test_4()
{
    var result := check_dict_case(map["STATE" := "NC", "ZIP" := "12345"]);
    expect result == true;
}

method {:test} test_5()
{
    var result := check_dict_case(map["fruit" := "Orange", "taste" := "Sweet"]);
    expect result == true;
}

method {:test} test_6()
{
    var result := check_dict_case(map[]);
    expect result == false;
}