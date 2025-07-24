function IsLowerCase(c: char): bool
{
    'a' <= c <= 'z'
}

function IsUpperCase(c: char): bool
{
    'A' <= c <= 'Z'
}

function ToUpperCase(c: char): char
    requires IsLowerCase(c)
{
    (c as int - 'a' as int + 'A' as int) as char
}

function ToLowerCase(c: char): char
    requires IsUpperCase(c)
{
    (c as int - 'A' as int + 'a' as int) as char
}

method flip_case(s: string) returns (result: string)
    ensures |result| == |s|
    ensures forall i :: 0 <= i < |s| ==> 
        (IsLowerCase(s[i]) ==> result[i] == ToUpperCase(s[i])) &&
        (IsUpperCase(s[i]) ==> result[i] == ToLowerCase(s[i])) &&
        (!IsLowerCase(s[i]) && !IsUpperCase(s[i]) ==> result[i] == s[i])
{
    result := "";
    var i := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        invariant |result| == i
        invariant forall j :: 0 <= j < i ==> 
            (IsLowerCase(s[j]) ==> result[j] == ToUpperCase(s[j])) &&
            (IsUpperCase(s[j]) ==> result[j] == ToLowerCase(s[j])) &&
            (!IsLowerCase(s[j]) && !IsUpperCase(s[j]) ==> result[j] == s[j])
        decreases |s| - i
    {
        var c := s[i];
        if IsLowerCase(c) {
            result := result + [ToUpperCase(c)];
        } else if IsUpperCase(c) {
            result := result + [ToLowerCase(c)];
        } else {
            result := result + [c];
        }
        i := i + 1;
    }
}