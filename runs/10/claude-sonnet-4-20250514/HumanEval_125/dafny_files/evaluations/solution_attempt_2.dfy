method split_words(txt: string) returns (result: seq<string>)
    ensures |result| > 0
    ensures (exists i :: 0 <= i < |txt| && txt[i] == ' ') ==> 
            (forall s :: s in result ==> |s| > 0)
    ensures (!(exists i :: 0 <= i < |txt| && txt[i] == ' ') && 
             (exists i :: 0 <= i < |txt| && txt[i] == ',')) ==> 
            |result| >= 1
    ensures (!(exists i :: 0 <= i < |txt| && txt[i] == ' ') && 
             !(exists i :: 0 <= i < |txt| && txt[i] == ',')) ==> 
            (|result| == 1 && IsNumericString(result[0]) && 
             StringToInt(result[0]) >= 0 && 
             StringToInt(result[0]) == CountOddPositionLowercaseChars(txt))
{
    // Check if string contains whitespace
    if exists i :: 0 <= i < |txt| && txt[i] == ' ' {
        result := SplitOnWhitespace(txt);
    } else if exists i :: 0 <= i < |txt| && txt[i] == ',' {
        result := SplitOnComma(txt);
    } else {
        var count := CountOddPositionLowercase(txt);
        var countStr := IntToString(count);
        result := [countStr];
    }
}

function CountOddPositionLowercaseChars(txt: string): int
{
    |set i | 0 <= i < |txt| && IsLowercase(txt[i]) && ((txt[i] as int) - ('a' as int)) % 2 == 1|
}

function StringToInt(s: string): int
    requires IsNumericString(s)
{
    if |s| == 0 then 0
    else if s[0] == '-' then -StringToNat(s[1..])
    else StringToNat(s)
}

function StringToNat(s: string): int
    requires forall i :: 0 <= i < |s| ==> '0' <= s[i] <= '9'
{
    if |s| == 0 then 0
    else (s[0] as int - '0' as int) * Pow10(|s| - 1) + StringToNat(s[1..])
}

function Pow10(n: int): int
    requires n >= 0
{
    if n == 0 then 1 else 10 * Pow10(n - 1)
}

predicate IsNumericString(s: string)
{
    |s| > 0 && (s[0] == '-' || ('0' <= s[0] <= '9')) &&
    (forall i :: 1 <= i < |s| ==> '0' <= s[i] <= '9') &&
    (|s| > 1 ==> s[0] != '0' || s[0] == '-')
}

method SplitOnWhitespace(txt: string) returns (words: seq<string>)
    requires exists i :: 0 <= i < |txt| && txt[i] == ' '
    ensures |words| > 0
    ensures forall s :: s in words ==> |s| > 0
{
    words := [];
    var current := "";
    var i := 0;
    
    while i < |txt|
        invariant 0 <= i <= |txt|
        decreases |txt| - i
    {
        if txt[i] == ' ' {
            if |current| > 0 {
                words := words + [current];
                current := "";
            }
        } else {
            current := current + [txt[i]];
        }
        i := i + 1;
    }
    
    if |current| > 0 {
        words := words + [current];
    }
    
    // Handle case where input is all spaces
    if |words| == 0 {
        words := [""];
    }
}

method SplitOnComma(txt: string) returns (words: seq<string>)
    requires exists i :: 0 <= i < |txt| && txt[i] == ','
    ensures |words| > 0
    ensures |words| >= 1
{
    words := [];
    var current := "";
    var i := 0;
    
    while i < |txt|
        invariant 0 <= i <= |txt|
        decreases |txt| - i
    {
        if txt[i] == ',' {
            words := words + [current];
            current := "";
        } else {
            current := current + [txt[i]];
        }
        i := i + 1;
    }
    
    words := words + [current];
}

method CountOddPositionLowercase(txt: string) returns (count: int)
    ensures count >= 0
    ensures count == |set i | 0 <= i < |txt| && IsLowercase(txt[i]) && ((txt[i] as int) - ('a' as int)) % 2 == 1|
{
    count := 0;
    var i := 0;
    
    while i < |txt|
        invariant 0 <= i <= |txt|
        invariant count >= 0
        invariant count == |set j | 0 <= j < i && IsLowercase(txt[j]) && ((txt[j] as int) - ('a' as int)) % 2 == 1|
        decreases |txt| - i
    {
        var ch := txt[i];
        if IsLowercase(ch) {
            var position := (ch as int) - ('a' as int);
            if position % 2 == 1 {
                count := count + 1;
            }
        }
        i := i + 1;
    }
}

predicate IsLowercase(ch: char)
{
    'a' <= ch <= 'z'
}

method IntToString(n: int) returns (s: string)
    ensures |s| > 0
    ensures IsNumericString(s)
    ensures n >= 0 ==> (forall i :: 0 <= i < |s| ==> '0' <= s[i] <= '9')
    ensures n < 0 ==> s[0] == '-' && (forall i :: 1 <= i < |s| ==> '0' <= s[i] <= '9')
    ensures StringToInt(s) == n
{
    if n == 0 {
        s := "0";
        return;
    }
    
    var digits := "";
    var num := if n < 0 then -n else n;
    
    while num > 0
        invariant num >= 0
        decreases num
    {
        var digit := num % 10;
        var digitChar := ('0' as int + digit) as char;
        digits := [digitChar] + digits;
        num := num / 10;
    }
    
    if n < 0 {
        s := "-" + digits;
    } else {
        s := digits;
    }
}