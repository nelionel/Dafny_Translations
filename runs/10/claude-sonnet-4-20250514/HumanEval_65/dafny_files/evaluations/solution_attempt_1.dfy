method circular_shift(x: int, shift: int) returns (result: string)
    ensures var digits := if x == 0 then "0" else int_to_string(if x >= 0 then x else -x)
    ensures var n := |digits|
    ensures shift > n ==> result == reverse_string(digits)
    ensures shift <= n && shift == 0 ==> result == digits
    ensures shift <= n && n == 0 ==> result == digits
    ensures shift <= n && shift > 0 && n > 0 ==> 
        (var normalized_shift := shift % n;
         result == digits[n - normalized_shift..] + digits[..n - normalized_shift])
{
    // Convert integer to string of digits using absolute value
    var absX := if x >= 0 then x else -x;
    var digits := "";
    
    if absX == 0 {
        digits := "0";
    } else {
        var temp := absX;
        while temp > 0
            invariant temp >= 0
            decreases temp
        {
            var digit := temp % 10;
            var digitChar := ('0' as int + digit) as char;
            digits := [digitChar] + digits;
            temp := temp / 10;
        }
    }
    
    var n := |digits|;
    
    // If shift is greater than number of digits, return reversed digits
    if shift > n {
        result := "";
        var i := n - 1;
        while i >= 0
            invariant -1 <= i < n
            invariant |result| == n - 1 - i
            decreases i + 1
        {
            result := result + [digits[i]];
            i := i - 1;
        }
        return;
    }
    
    // Handle case where shift is 0 or n is 0
    if shift == 0 || n == 0 {
        result := digits;
        return;
    }
    
    // Normalize shift to be within range [0, n)
    var normalizedShift := shift % n;
    
    // Perform circular right shift
    // Right shift by 'normalizedShift' means taking last 'normalizedShift' digits 
    // and moving them to front
    result := digits[n - normalizedShift..] + digits[..n - normalizedShift];
}

function int_to_string(x: int): string
    requires x >= 0
{
    if x == 0 then "0"
    else int_to_string_helper(x)
}

function int_to_string_helper(x: int): string
    requires x > 0
    decreases x
{
    if x < 10 then [('0' as int + x) as char]
    else int_to_string_helper(x / 10) + [('0' as int + (x % 10)) as char]
}

function reverse_string(s: string): string
{
    if |s| == 0 then ""
    else reverse_string(s[1..]) + [s[0]]
}