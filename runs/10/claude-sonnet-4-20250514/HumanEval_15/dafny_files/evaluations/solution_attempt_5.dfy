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
    ensures n == 0 ==> result == "0"
    ensures n > 0 ==> result[0] == '0'
    ensures n > 0 ==> ' ' in result
    ensures n == 1 ==> result == "0 1"
    ensures n == 2 ==> result == "0 1 2"
    ensures n == 3 ==> result == "0 1 2 3"
    ensures n > 0 ==> result[|result|-1] != ' '  // doesn't end with space
    ensures forall i :: 0 <= i < |result| ==> (result[i] == ' ' || ('0' <= result[i] <= '9'))
    // The result contains exactly n spaces (separating n+1 numbers)
    ensures n > 0 ==> |[i | i in 0..|result| :: result[i] == ' ']| == n
    // The result starts with "0" and when n > 0, follows pattern "0 1 2 ... n"
    ensures result[0] == '0'
    ensures n > 0 ==> (|result| >= 3 && result[1] == ' ' && result[2] == '1')
    ensures n > 1 ==> (|result| >= 5 && result[3] == ' ' && result[4] == '2')
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
        invariant result[0] == '0'
        decreases n - i
    {
        var num_str := IntToString(i);
        result := result + " " + num_str;
        i := i + 1;
    }
}