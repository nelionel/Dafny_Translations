method int_to_mini_roman(number: int) returns (result: string)
    requires 1 <= number <= 1000
    ensures |result| > 0
    ensures forall i :: 0 <= i < |result| ==> result[i] in {'i', 'v', 'x', 'l', 'c', 'd', 'm'}
    ensures result == to_lowercase(int_to_roman_uppercase(number))
    ensures number == 1 ==> result == "i"
    ensures number == 4 ==> result == "iv"
    ensures number == 5 ==> result == "v"
    ensures number == 9 ==> result == "ix"
    ensures number == 10 ==> result == "x"
    ensures number == 19 ==> result == "xix"
    ensures number == 152 ==> result == "clii"
    ensures number == 426 ==> result == "cdxxvi"
    ensures number == 1000 ==> result == "m"
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

function int_to_roman_uppercase(number: int): string
    requires 1 <= number <= 1000
{
    var values := [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    var symbols := ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
    int_to_roman_helper(number, values, symbols, 0)
}

function int_to_roman_helper(remaining: int, values: seq<int>, symbols: seq<string>, index: int): string
    requires |values| == |symbols|
    requires 0 <= index <= |values|
    requires remaining >= 0
    requires |values| == 13
    requires values == [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    requires symbols == ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
    decreases |values| - index
{
    if index >= |values| then ""
    else if remaining == 0 then ""
    else
        var count := remaining / values[index];
        repeat_string(symbols[index], count) + 
        int_to_roman_helper(remaining - values[index] * count, values, symbols, index + 1)
}

function repeat_string(s: string, count: int): string
    requires count >= 0
{
    if count == 0 then ""
    else s + repeat_string(s, count - 1)
}

method to_lowercase(s: string) returns (result: string)
    ensures |result| == |s|
    ensures forall i :: 0 <= i < |s| ==> 
        (if 'A' <= s[i] <= 'Z' then result[i] == (s[i] as int - 'A' as int + 'a' as int) as char
         else result[i] == s[i])
{
    result := "";
    var i := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        invariant |result| == i
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