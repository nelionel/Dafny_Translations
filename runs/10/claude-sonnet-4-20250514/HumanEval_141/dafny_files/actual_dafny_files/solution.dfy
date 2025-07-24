method file_name_check(file_name: string) returns (result: string)
    ensures result == "Yes" || result == "No"
    ensures result == "Yes" <==> (
        CountChar(file_name, '.') == 1 &&
        (exists i :: 0 <= i < |file_name| && file_name[i] == '.' &&
            i > 0 &&
            IsAlpha(file_name[0]) &&
            IsValidExtension(file_name[i+1..]) &&
            CountDigits(file_name) <= 3)
    )
{
    // Check if there's exactly one dot
    var dot_count := CountChar(file_name, '.');
    if dot_count != 1 {
        result := "No";
        return;
    }
    
    // Split by dot
    var name_part, extension_part := SplitByDot(file_name);
    
    // Check if name part is not empty
    if |name_part| == 0 {
        result := "No";
        return;
    }
    
    // Check if name part starts with a letter
    if !IsAlpha(name_part[0]) {
        result := "No";
        return;
    }
    
    // Check if extension is valid
    if !IsValidExtension(extension_part) {
        result := "No";
        return;
    }
    
    // Count digits in entire filename
    var digit_count := CountDigits(file_name);
    if digit_count > 3 {
        result := "No";
        return;
    }
    
    result := "Yes";
}

function CountChar(s: string, c: char) : int
    decreases |s|
{
    if |s| == 0 then 0
    else if s[0] == c then 1 + CountChar(s[1..], c)
    else CountChar(s[1..], c)
}

method SplitByDot(s: string) returns (before: string, after: string)
    requires CountChar(s, '.') == 1
    ensures |before| + |after| + 1 == |s|
    ensures before + "." + after == s
{
    var i := 0;
    while i < |s| && s[i] != '.'
        invariant 0 <= i <= |s|
        invariant forall j :: 0 <= j < i ==> s[j] != '.'
        decreases |s| - i
    {
        i := i + 1;
    }
    before := s[..i];
    after := s[i+1..];
}

function IsAlpha(c: char) : bool
{
    ('a' <= c <= 'z') || ('A' <= c <= 'Z')
}

function IsDigit(c: char) : bool
{
    '0' <= c <= '9'
}

function CountDigits(s: string) : int
    decreases |s|
{
    if |s| == 0 then 0
    else if IsDigit(s[0]) then 1 + CountDigits(s[1..])
    else CountDigits(s[1..])
}

function IsValidExtension(ext: string) : bool
{
    ext == "txt" || ext == "exe" || ext == "dll"
}