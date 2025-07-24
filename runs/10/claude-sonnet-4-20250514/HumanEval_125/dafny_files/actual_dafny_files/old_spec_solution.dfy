method split_words(txt: string) returns (result: seq<string>)
    ensures |result| > 0
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

method SplitOnWhitespace(txt: string) returns (words: seq<string>)
    requires exists i :: 0 <= i < |txt| && txt[i] == ' '
    ensures |words| > 0
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
{
    count := 0;
    var i := 0;
    
    while i < |txt|
        invariant 0 <= i <= |txt|
        invariant count >= 0
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