method int_to_mini_roman(number: int) returns (result: string)
    requires 1 <= number <= 1000
    ensures |result| > 0
    ensures forall i :: 0 <= i < |result| ==> result[i] in {'i', 'v', 'x', 'l', 'c', 'd', 'm'}
    ensures result == to_lowercase_spec(int_to_roman_spec(number))
    ensures int_to_roman_spec(number) != "" // Roman numeral is never empty
    ensures is_valid_roman_numeral(to_uppercase(result))
    ensures roman_to_int_spec(to_uppercase(result)) == number
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
        invariant remaining + roman_to_int_spec(result) == number
        decreases |values| - i
    {
        var count := remaining / values[i];
        if count > 0 {
            var j := 0;
            while j < count
                invariant 0 <= j <= count
                invariant remaining + roman_to_int_spec(result) + values[i] * j == number
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
    ensures roman_to_int_spec(int_to_roman_spec(number)) == number
    ensures is_valid_roman_numeral(int_to_roman_spec(number))
    ensures forall c :: c in int_to_roman_spec(number) ==> c in {'I', 'V', 'X', 'L', 'C', 'D', 'M'}
{
    var values := [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    var symbols := ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
    convert_to_roman_recursive(number, values, symbols, 0)
}

function convert_to_roman_recursive(remaining: int, values: seq<int>, symbols: seq<string>, index: int): string
    requires 0 <= remaining
    requires 0 <= index <= |values|
    requires |values| == |symbols|
    requires values == [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    requires symbols == ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
    decreases |values| - index, remaining
{
    if remaining == 0 || index >= |values| then ""
    else if remaining >= values[index] then
        symbols[index] + convert_to_roman_recursive(remaining - values[index], values, symbols, index)
    else
        convert_to_roman_recursive(remaining, values, symbols, index + 1)
}

function roman_to_int_spec(roman: string): int
    requires is_valid_roman_numeral(roman)
{
    if roman == "" then 0
    else if |roman| >= 2 && roman[0..2] == "CM" then 900 + roman_to_int_spec(roman[2..])
    else if |roman| >= 2 && roman[0..2] == "CD" then 400 + roman_to_int_spec(roman[2..])
    else if |roman| >= 2 && roman[0..2] == "XC" then 90 + roman_to_int_spec(roman[2..])
    else if |roman| >= 2 && roman[0..2] == "XL" then 40 + roman_to_int_spec(roman[2..])
    else if |roman| >= 2 && roman[0..2] == "IX" then 9 + roman_to_int_spec(roman[2..])
    else if |roman| >= 2 && roman[0..2] == "IV" then 4 + roman_to_int_spec(roman[2..])
    else if roman[0] == 'M' then 1000 + roman_to_int_spec(roman[1..])
    else if roman[0] == 'D' then 500 + roman_to_int_spec(roman[1..])
    else if roman[0] == 'C' then 100 + roman_to_int_spec(roman[1..])
    else if roman[0] == 'L' then 50 + roman_to_int_spec(roman[1..])
    else if roman[0] == 'X' then 10 + roman_to_int_spec(roman[1..])
    else if roman[0] == 'V' then 5 + roman_to_int_spec(roman[1..])
    else if roman[0] == 'I' then 1 + roman_to_int_spec(roman[1..])
    else 0
}

predicate is_valid_roman_numeral(s: string)
{
    forall i :: 0 <= i < |s| ==> s[i] in {'I', 'V', 'X', 'L', 'C', 'D', 'M'}
}

function to_lowercase_spec(s: string): string
    ensures |to_lowercase_spec(s)| == |s|
    ensures forall i :: 0 <= i < |s| ==> 
        (if 'A' <= s[i] <= 'Z' then to_lowercase_spec(s)[i] == (s[i] as int - 'A' as int + 'a' as int) as char
         else to_lowercase_spec(s)[i] == s[i])
{
    if s == "" then ""
    else 
        var first_char := if 'A' <= s[0] <= 'Z' then (s[0] as int - 'A' as int + 'a' as int) as char else s[0];
        [first_char] + to_lowercase_spec(s[1..])
}

function to_uppercase(s: string): string
    ensures |to_uppercase(s)| == |s|
{
    if s == "" then ""
    else
        var first_char := if 'a' <= s[0] <= 'z' then (s[0] as int - 'a' as int + 'A' as int) as char else s[0];
        [first_char] + to_uppercase(s[1..])
}

method to_lowercase(s: string) returns (result: string)
    ensures |result| == |s|
    ensures result == to_lowercase_spec(s)
    ensures forall i :: 0 <= i < |s| ==> 
        (if 'A' <= s[i] <= 'Z' then result[i] == (s[i] as int - 'A' as int + 'a' as int) as char
         else result[i] == s[i])
{
    result := "";
    var i := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        invariant |result| == i
        invariant result == to_lowercase_spec(s[0..i])
        invariant forall j :: 0 <= j < i ==> 
            (if 'A' <= s[j] <= 'Z' then result[j] == (s[j] as int - 'A' as int + 'a' as int) as char
             else result[j] == s[j])
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