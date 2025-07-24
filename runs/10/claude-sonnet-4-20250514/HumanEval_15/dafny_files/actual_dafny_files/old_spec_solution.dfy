method IntToString(n: int) returns (s: string)
    requires n >= 0
    ensures |s| > 0
{
    if n == 0 {
        s := "0";
    } else {
        s := "";
        var temp := n;
        var digits: seq<int> := [];
        
        while temp > 0
            invariant temp >= 0
            decreases temp
        {
            digits := [temp % 10] + digits;
            temp := temp / 10;
        }
        
        var i := 0;
        while i < |digits|
            invariant 0 <= i <= |digits|
            invariant i == 0 ==> s == ""
            invariant i > 0 ==> |s| == i
            decreases |digits| - i
        {
            var digit_char := (48 + digits[i]) as char; // '0' is ASCII 48
            s := s + [digit_char];
            i := i + 1;
        }
    }
}

method string_sequence(n: int) returns (result: string)
    requires n >= 0
    ensures |result| > 0
{
    var first_num := IntToString(0);
    result := first_num;
    
    if n == 0 {
        return;
    }
    
    var i := 1;
    while i <= n
        invariant 1 <= i <= n + 1
        invariant |result| > 0
        decreases n - i
    {
        var num_str := IntToString(i);
        result := result + " " + num_str;
        i := i + 1;
    }
}