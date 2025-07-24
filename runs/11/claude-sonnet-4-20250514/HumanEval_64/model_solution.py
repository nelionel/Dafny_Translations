def vowels_count(s):
    """Write a function vowels_count which takes a string representing
    a word as input and returns the number of vowels in the string.
    Vowels in this case are 'a', 'e', 'i', 'o', 'u'. Here, 'y' is also a
    vowel, but only when it is at the end of the given word.

    Example:
    >>> vowels_count("abcde")
    2
    >>> vowels_count("ACEDY")
    3
    """
    if not s:
        return 0
    
    vowels = set('aeiouAEIOU')
    count = 0
    
    # Count regular vowels
    for char in s:
        if char in vowels:
            count += 1
    
    # Check if 'y' or 'Y' is at the end
    if s[-1].lower() == 'y':
        count += 1
    
    return count

# Test cases
def test_vowels_count():
    # Original test cases
    assert vowels_count("abcde") == 2
    assert vowels_count("ACEDY") == 3
    
    # Additional test cases
    assert vowels_count("") == 0  # Empty string
    assert vowels_count("bcdfg") == 0  # No vowels
    assert vowels_count("aeiou") == 5  # All regular vowels
    assert vowels_count("AEIOU") == 5  # All uppercase vowels
    assert vowels_count("y") == 1  # Single 'y' at end
    assert vowels_count("Y") == 1  # Single uppercase 'Y' at end
    assert vowels_count("happy") == 2  # 'y' at end + one other vowel
    assert vowels_count("python") == 2  # 'y' not at end
    assert vowels_count("gym") == 1  # 'y' not at end, no other vowels
    assert vowels_count("why") == 1  # 'y' at end, no other vowels
    assert vowels_count("rhythm") == 1  # 'y' not at end, no regular vowels
    assert vowels_count("mystery") == 2  # 'y' at end + one regular vowel
    assert vowels_count("yellow") == 3  # 'y' not at end + regular vowels
    assert vowels_count("fly") == 1  # 'y' at end, no other vowels
    assert vowels_count("dry") == 1  # 'y' at end, no other vowels
    assert vowels_count("cry") == 1  # 'y' at end, no other vowels
    assert vowels_count("sky") == 1  # 'y' at end, no other vowels
    assert vowels_count("beauty") == 4  # 'y' at end + multiple vowels
    assert vowels_count("lovely") == 3  # 'y' at end + multiple vowels
    assert vowels_count("playing") == 3  # 'y' not at end + multiple vowels
    assert vowels_count("xyz") == 0  # No vowels, consonants only
    assert vowels_count("ayeio") == 5  # 'y' not at end + all other vowels
    
    print("All test cases passed!")

# Run the tests
test_vowels_count()