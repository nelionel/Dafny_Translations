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
    
    # We need at least 3 characters for a vowel to be between two consonants
    if len(word) < 3:
        return ""
    
    # Iterate from right to left, excluding first and last characters
    for i in range(len(word) - 2, 0, -1):
        char = word[i]
        if char in vowels:
            # Check if both neighbors are consonants
            left_neighbor = word[i - 1]
            right_neighbor = word[i + 1]
            
            if left_neighbor not in vowels and right_neighbor not in vowels:
                return char
    
    return ""