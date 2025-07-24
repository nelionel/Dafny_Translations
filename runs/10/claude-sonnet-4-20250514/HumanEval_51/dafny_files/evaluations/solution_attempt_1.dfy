method remove_vowels(text: string) returns (result: string)
    ensures forall i :: 0 <= i < |result| ==> result[i] !in "aeiouAEIOU"
    ensures |result| <= |text|
    ensures result == seq(i | 0 <= i < |text| && text[i] !in "aeiouAEIOU" :: text[i])
{
    var vowels := "aeiouAEIOU";
    result := "";
    var i := 0;
    
    while i < |text|
        invariant 0 <= i <= |text|
        invariant forall j :: 0 <= j < |result| ==> result[j] !in vowels
        invariant |result| <= i
        invariant result == seq(k | 0 <= k < i && text[k] !in vowels :: text[k])
        decreases |text| - i
    {
        if text[i] !in vowels {
            result := result + [text[i]];
        }
        i := i + 1;
    }
}