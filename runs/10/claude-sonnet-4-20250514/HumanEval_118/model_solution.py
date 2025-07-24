def get_closest_vowel(word):
    """You are given a word. Your task is to find the closest vowel that stands between 
    two consonants from the right side of the word (case sensitive).
    
    Vowels in the beginning and ending doesn't count. Return empty string if you didn't
    find any vowel met the above condition. 

    You may assume that the given string contains English letter only.

    Example:
    get_closest_vowel("yogurt") ==> "u"
    get_closest_vowel("FULL") ==> "U"
    get_closest_vowel("quick") ==> ""
    get_closest_vowel("ab") ==> ""
    """
    vowels = "aeiouAEIOU"
    
    # Need at least 3 characters to have a vowel between two consonants
    if len(word) < 3:
        return ""
    
    # Search from right to left, excluding the first and last characters
    for i in range(len(word) - 2, 0, -1):
        # Check if current character is a vowel
        if word[i] in vowels:
            # Check if it's between two consonants
            if word[i-1] not in vowels and word[i+1] not in vowels:
                return word[i]
    
    return ""