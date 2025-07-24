method check_dict_case(dict: map<string, string>) returns (result: bool)
    ensures result == (|dict| > 0 && (AllKeysLowerCase(dict) || AllKeysUpperCase(dict)))
{
    // Return False if dictionary is empty
    if |dict| == 0 {
        return false;
    }
    
    // Get all keys
    var keys := dict.Keys;
    
    // Check if all keys are lowercase
    var all_lower := forall k :: k in keys ==> IsLowerCase(k);
    
    // Check if all keys are uppercase  
    var all_upper := forall k :: k in keys ==> IsUpperCase(k);
    
    // Return True if all keys are either all lowercase or all uppercase
    return all_lower || all_upper;
}

predicate IsLowerCase(s: string)
{
    |s| > 0 && 
    (exists i :: 0 <= i < |s| && 'a' <= s[i] <= 'z') &&
    (forall i :: 0 <= i < |s| && IsLetter(s[i]) ==> 'a' <= s[i] <= 'z')
}

predicate IsUpperCase(s: string)
{
    |s| > 0 && 
    (exists i :: 0 <= i < |s| && 'A' <= s[i] <= 'Z') &&
    (forall i :: 0 <= i < |s| && IsLetter(s[i]) ==> 'A' <= s[i] <= 'Z')
}

predicate IsLetter(c: char)
{
    ('a' <= c <= 'z') || ('A' <= c <= 'Z')
}

predicate AllKeysLowerCase(dict: map<string, string>)
{
    forall k :: k in dict.Keys ==> IsLowerCase(k)
}

predicate AllKeysUpperCase(dict: map<string, string>)
{
    forall k :: k in dict.Keys ==> IsUpperCase(k)
}