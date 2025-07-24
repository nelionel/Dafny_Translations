method remove_vowels(text: string) returns (result: string)
    ensures forall i :: 0 <= i < |result| ==> result[i] !in "aeiouAEIOU"
    ensures |result| <= |text|
    ensures forall i, j :: 0 <= i < j < |result| ==> 
        exists ti, tj :: 0 <= ti < tj < |text| && text[ti] == result[i] && text[tj] == result[j]
    ensures forall i :: 0 <= i < |text| && text[i] !in "aeiouAEIOU" ==> 
        exists j :: 0 <= j < |result| && result[j] == text[i]
{
    var vowels := "aeiouAEIOU";
    result := "";
    var i := 0;
    
    while i < |text|
        invariant 0 <= i <= |text|
        invariant forall j :: 0 <= j < |result| ==> result[j] !in vowels
        invariant |result| <= i
        decreases |text| - i
    {
        if text[i] !in vowels {
            result := result + [text[i]];
        }
        i := i + 1;
    }
}