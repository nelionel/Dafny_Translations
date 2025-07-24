method int_to_mini_roman(number: int) returns (result: string)
    requires 1 <= number <= 1000
    ensures |result| > 0
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

method to_lowercase(s: string) returns (result: string)
    ensures |result| == |s|
{
    result := "";
    var i := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        invariant |result| == i
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