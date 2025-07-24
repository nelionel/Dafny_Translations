method numerical_letter_grade(grades: seq<real>) returns (letter_grades: seq<string>)
{
    letter_grades := [];
}

function grade_to_letter(gpa: real): string
{
    "E"
}

method {:test} test_0()
{
    var result := numerical_letter_grade([4.0, 3.0, 1.7, 2.0, 3.5]);
    expect result == ["A+", "B", "C-", "C", "A-"];
}

method {:test} test_1()
{
    var result := numerical_letter_grade([1.2]);
    expect result == ["D+"];
}

method {:test} test_2()
{
    var result := numerical_letter_grade([0.5]);
    expect result == ["D-"];
}

method {:test} test_3()
{
    var result := numerical_letter_grade([0.0]);
    expect result == ["E"];
}

method {:test} test_4()
{
    var result := numerical_letter_grade([1.0, 0.3, 1.5, 2.8, 3.3]);
    expect result == ["D", "D-", "C-", "B", "B+"];
}

method {:test} test_5()
{
    var result := numerical_letter_grade([0.0, 0.7]);
    expect result == ["E", "D-"];
}