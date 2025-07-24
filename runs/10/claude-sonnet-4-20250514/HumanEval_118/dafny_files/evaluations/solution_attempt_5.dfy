method get_closest_vowel(word: string) returns (result: string)
    requires |word| >= 0
    ensures result == "" || (|result| == 1 && result[0] in "aeiouAEIOU")
    ensures |word| < 3 ==> result == ""
    ensures |word| >= 3 ==> (
        (result == "" ==> (forall i :: 1 <= i <= |word|-2 ==> 
            !(word[i] in "aeiouAEIOU" && word[i-1] !in "aeiouAEIOU" && word[i+1] !in "aeiouAEIOU"))) &&
        (result != "" ==> (exists i :: 1 <= i <= |word|-2 && 
            word[i] in "aeiouAEIOU" && word[i-1] !in "aeiouAEIOU" && word[i+1] !in "aeiouAEIOU" &&
            result == [word[i]] &&
            (forall j :: i < j <= |word|-2 ==> 
                !(word[j] in "aeiouAEIOU" && word[j-1] !in "aeiouAEIOU" && word[j+1] !in "aeiouAEIOU"))))
    )
{
    var vowels := "aeiouAEIOU";
    
    // Need at least 3 characters to have a vowel between two consonants
    if |word| < 3 {
        return "";
    }
    
    // Search from right to left, excluding the first and last characters
    var i := |word| - 2;
    while i > 0
        invariant 0 <= i <= |word| - 2
        decreases i
    {
        // Check if current character is a vowel
        if word[i] in vowels {
            // Check if it's between two consonants
            if word[i-1] !in vowels && word[i+1] !in vowels {
                return [word[i]];
            }
        }
        i := i - 1;
    }
    
    return "";
}