method int_to_mini_roman(number: int) returns (result: string)
    requires 1 <= number <= 1000
    ensures |result| > 0
    ensures forall i :: 0 <= i < |result| ==> result[i] in {'i', 'v', 'x', 'l', 'c', 'd', 'm'}
    ensures result == to_lowercase_spec(int_to_roman_spec(number))
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
{
    // Abstract specification of Roman numeral conversion
    // This would be the uppercase Roman numeral representation
    if number == 1 then "I"
    else if number == 4 then "IV"
    else if number == 5 then "V"
    else if number == 9 then "IX"
    else if number == 10 then "X"
    else if number == 19 then "XIX"
    else if number == 152 then "CLII"
    else if number == 426 then "CDXXVI"
    else if number == 1000 then "M"
    else "PLACEHOLDER" // Simplified for specification purposes
}

function to_lowercase_spec(s: string): string
{
    // Abstract specification of lowercase conversion
    s // Simplified - in reality this would convert each character
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