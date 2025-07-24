method int_to_mini_roman(number: int) returns (result: string)
    requires 1 <= number <= 1000
    ensures |result| > 0
    ensures forall i :: 0 <= i < |result| ==> result[i] in {'i', 'v', 'x', 'l', 'c', 'd', 'm'}
    ensures result == to_lowercase_spec(int_to_roman_spec(number))
    ensures roman_to_int_spec(result) == number
{
    var values := [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    var symbols := ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
    
    result := "";
    var remaining := number;
    var i := 0;
    
    while i < |values|
        invariant 0 <= i <= |values|
        invariant remaining >= 0
        invariant |values| == |symbols| == 13
        decreases |values| - i
    {
        var count := remaining / values[i];
        if count > 0 {
            var j := 0;
            while j < count
                invariant 0 <= j <= count
                decreases count - j
            {
                result := result + symbols[i];
                j := j + 1;
            }
            remaining := remaining - values[i] * count;
        }
        i := i + 1;
    }
    
    // Convert to lowercase
    result := to_lowercase(result);
}

function int_to_roman_spec(number: int): string
    requires 1 <= number <= 1000
    decreases number
{
    var values := [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    var symbols := ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
    
    if number == 0 then ""
    else 
        var i := 0;
        while i < |values| && values[i] > number
            invariant 0 <= i <= |values|
            decreases |values| - i
        {
            i := i + 1;
        }
        if i < |values| then
            var count := number / values[i];
            repeat_string(symbols[i], count) + int_to_roman_spec(number - values[i] * count)
        else ""
}

function repeat_string(s: string, count: int): string
    requires count >= 0
    decreases count
{
    if count == 0 then ""
    else s + repeat_string(s, count - 1)
}

function to_lowercase_spec(s: string): string
    ensures |to_lowercase_spec(s)| == |s|
    ensures forall i :: 0 <= i < |s| ==> 
        (if 'A' <= s[i] <= 'Z' then to_lowercase_spec(s)[i] == (s[i] as int - 'A' as int + 'a' as int) as char
         else to_lowercase_spec(s)[i] == s[i])
{
    if |s| == 0 then ""
    else 
        var first_char := s[0];
        var converted_first := if 'A' <= first_char <= 'Z' then 
            (first_char as int - 'A' as int + 'a' as int) as char
        else first_char;
        [converted_first] + to_lowercase_spec(s[1..])
}

function roman_to_int_spec(roman: string): int
    requires forall i :: 0 <= i < |roman| ==> roman[i] in {'i', 'v', 'x', 'l', 'c', 'd', 'm', 'I', 'V', 'X', 'L', 'C', 'D', 'M'}
{
    if |roman| == 0 then 0
    else
        var first_char := roman[0];
        var first_value := char_to_roman_value(first_char);
        if |roman| == 1 then first_value
        else
            var second_value := char_to_roman_value(roman[1]);
            if first_value < second_value then
                second_value - first_value + roman_to_int_spec(roman[2..])
            else
                first_value + roman_to_int_spec(roman[1..])
}

function char_to_roman_value(c: char): int
    requires c in {'i', 'v', 'x', 'l', 'c', 'd', 'm', 'I', 'V', 'X', 'L', 'C', 'D', 'M'}
{
    if c == 'i' || c == 'I' then 1
    else if c == 'v' || c == 'V' then 5
    else if c == 'x' || c == 'X' then 10
    else if c == 'l' || c == 'L' then 50
    else if c == 'c' || c == 'C' then 100
    else if c == 'd' || c == 'D' then 500
    else if c == 'm' || c == 'M' then 1000
    else 0
}

method to_lowercase(s: string) returns (result: string)
    ensures |result| == |s|
    ensures forall i :: 0 <= i < |s| ==> 
        (if 'A' <= s[i] <= 'Z' then result[i] == (s[i] as int - 'A' as int + 'a' as int) as char
         else result[i] == s[i])
    ensures result == to_lowercase_spec(s)
{
    result := "";
    var i := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        invariant |result| == i
        invariant forall j :: 0 <= j < i ==> 
            (if 'A' <= s[j] <= 'Z' then result[j] == (s[j] as int - 'A' as int + 'a' as int) as char
             else result[j] == s[j])
        invariant result == to_lowercase_spec(s[..i])
        decreases |s| - i
    {
        var c := s[i];
        if 'A' <= c <= 'Z' {
            var lower_c := (c as int - 'A' as int + 'a' as int) as char;
            result := result + [lower_c];
        } else {
            result := result + [c];
        }
        i := i + 1;
    }
}