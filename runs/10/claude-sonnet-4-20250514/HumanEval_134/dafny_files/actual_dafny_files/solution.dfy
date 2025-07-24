predicate IsAlpha(c: char)
{
    ('a' <= c <= 'z') || ('A' <= c <= 'Z')
}

method check_if_last_char_is_a_letter(txt: string) returns (result: bool)
    ensures result == (|txt| > 0 && IsAlpha(txt[|txt|-1]) && (|txt| == 1 || txt[|txt|-2] == ' '))
{
    if |txt| == 0 {
        return false;
    }
    
    if !IsAlpha(txt[|txt|-1]) {
        return false;
    }
    
    if |txt| == 1 {
        return true;
    }
    
    return txt[|txt|-2] == ' ';
}