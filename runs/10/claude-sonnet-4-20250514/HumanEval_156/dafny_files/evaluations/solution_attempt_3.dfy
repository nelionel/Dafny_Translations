method int_to_mini_roman(number: int) returns (result: string)
    requires 1 <= number <= 1000
    ensures |result| > 0
    ensures forall i :: 0 <= i < |result| ==> result[i] in {'i', 'v', 'x', 'l', 'c', 'd', 'm'}
    ensures result == to_lowercase(int_to_roman_spec(number))
    ensures roman_value(result) == number
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
        invariant roman_value(to_lowercase(result)) + remaining == number
        decreases |values| - i
    {
        var count := remaining / values[i];
        if count > 0 {
            var j := 0;
            while j < count
                invariant 0 <= j <= count
                invariant roman_value(to_lowercase(result)) + remaining + values[i] * j == number
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
    ensures roman_value(to_lowercase(int_to_roman_spec(number))) == number
{
    var values := [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    var symbols := ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
    build_roman(number, values, symbols, 0, "")
}

function build_roman(remaining: int, values: seq<int>, symbols: seq<string>, index: int, acc: string): string
    requires |values| == |symbols| == 13
    requires 0 <= index <= |values|
    requires remaining >= 0
    requires values == [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    requires symbols == ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
    decreases |values| - index, remaining
{
    if index >= |values| || remaining == 0 then acc
    else if remaining >= values[index] then
        build_roman(remaining - values[index], values, symbols, index, acc + symbols[index])
    else
        build_roman(remaining, values, symbols, index + 1, acc)
}

function roman_value(s: string): int
    requires forall i :: 0 <= i < |s| ==> s[i] in {'i', 'v', 'x', 'l', 'c', 'd', 'm', 'I', 'V', 'X', 'L', 'C', 'D', 'M'}
{
    if |s| == 0 then 0
    else char_value(s[0]) + roman_value(s[1..])
}

function char_value(c: char): int
    requires c in {'i', 'v', 'x', 'l', 'c', 'd', 'm', 'I', 'V', 'X', 'L', 'C', 'D', 'M'}
{
    match c
        case 'I' | 'i' => 1
        case 'V' | 'v' => 5
        case 'X' | 'x' => 10
        case 'L' | 'l' => 50
        case 'C' | 'c' => 100
        case 'D' | 'd' => 500
        case 'M' | 'm' => 1000
}

method to_lowercase(s: string) returns (result: string)
    ensures |result| == |s|
    ensures forall i :: 0 <= i < |s| ==> 
        (if 'A' <= s[i] <= 'Z' then result[i] == (s[i] as int - 'A' as int + 'a' as int) as char
         else result[i] == s[i])
    ensures forall i :: 0 <= i < |s| ==> 
        (s[i] in {'A'..'Z'} ==> result[i] in {'a'..'z'})
    ensures forall i :: 0 <= i < |s| ==> 
        (s[i] in {'a'..'z'} ==> result[i] == s[i])
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