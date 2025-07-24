method change_base(x: int, base: int) returns (result: string)
    requires x >= 0
    requires 2 <= base < 10
    ensures |result| >= 1
    ensures forall i :: 0 <= i < |result| ==> '0' <= result[i] <= '9'
    ensures forall i :: 0 <= i < |result| ==> result[i] as int - '0' as int < base
    ensures x == 0 <==> result == "0"
    ensures x > 0 ==> result[0] != '0'
{
    if x == 0 {
        return "0";
    }
    
    var digits: seq<string> := [];
    var temp_x := x;
    
    while temp_x > 0
        invariant temp_x >= 0
        decreases temp_x
    {
        var digit := temp_x % base;
        var digit_char := if digit == 0 then "0"
                         else if digit == 1 then "1"
                         else if digit == 2 then "2"
                         else if digit == 3 then "3"
                         else if digit == 4 then "4"
                         else if digit == 5 then "5"
                         else if digit == 6 then "6"
                         else if digit == 7 then "7"
                         else if digit == 8 then "8"
                         else "9";
        digits := [digit_char] + digits;  // prepend to get correct order
        temp_x := temp_x / base;
    }
    
    // Join the digits
    result := "";
    var i := 0;
    while i < |digits|
        invariant 0 <= i <= |digits|
        decreases |digits| - i
    {
        result := result + digits[i];
        i := i + 1;
    }
}