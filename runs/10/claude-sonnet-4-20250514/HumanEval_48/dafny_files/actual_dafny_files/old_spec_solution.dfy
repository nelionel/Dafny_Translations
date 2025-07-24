function ToLowercaseChar(c: char): char
{
    if 'A' <= c <= 'Z' then
        (c as int - 'A' as int + 'a' as int) as char
    else
        c
}

function ToLowercase(s: string): string
    decreases |s|
{
    if |s| == 0 then ""
    else [ToLowercaseChar(s[0])] + ToLowercase(s[1..])
}

function Reverse(s: string): string
    decreases |s|
{
    if |s| == 0 then ""
    else Reverse(s[1..]) + [s[0]]
}

method is_palindrome(text: string) returns (result: bool)
    ensures result <==> ToLowercase(text) == Reverse(ToLowercase(text))
{
    var lowercased := ToLowercase(text);
    var reversed := Reverse(lowercased);
    result := lowercased == reversed;
}