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
    
    vowels = 'aeiouAEIOU'
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
    # Basic examples from the prompt
    assert vowels_count("abcde") == 2  # 'a', 'e'
    assert vowels_count("ACEDY") == 3  # 'A', 'E', 'Y' (at end)
    
    # Empty string
    assert vowels_count("") == 0
    
    # Single characters
    assert vowels_count("a") == 1
    assert vowels_count("b") == 0
    assert vowels_count("y") == 1  # y at end
    assert vowels_count("Y") == 1  # Y at end
    
    # No vowels
    assert vowels_count("bcdfg") == 0
    assert vowels_count("xyz") == 0  # y not at end
    
    # All vowels
    assert vowels_count("aeiou") == 5
    assert vowels_count("AEIOU") == 5
    
    # Mixed case
    assert vowels_count("Hello") == 2  # 'e', 'o'
    assert vowels_count("HELLO") == 2  # 'E', 'O'
    assert vowels_count("HeLLo") == 2  # 'e', 'o'
    
    # Y at different positions
    assert vowels_count("yes") == 1  # 'e' only, y not at end
    assert vowels_count("my") == 1   # 'y' at end
    assert vowels_count("gym") == 0  # y not at end, no other vowels
    assert vowels_count("happy") == 2 # 'a', 'y' at end
    assert vowels_count("yellow") == 3 # 'e', 'o', 'o' (y not at end)
    
    # Multiple vowels
    assert vowels_count("beautiful") == 5  # 'e', 'a', 'u', 'i', 'u'
    assert vowels_count("education") == 5  # 'e', 'u', 'a', 'i', 'o'
    assert vowels_count("university") == 4 # 'u', 'i', 'e', 'i', 'y' at end
    
    # Words with repeated vowels
    assert vowels_count("queue") == 4  # 'u', 'e', 'u', 'e'
    assert vowels_count("aaa") == 3
    assert vowels_count("eeee") == 4
    
    # Complex cases
    assert vowels_count("rhythm") == 0  # no vowels, y not at end
    assert vowels_count("fly") == 1     # 'y' at end
    assert vowels_count("cry") == 1     # 'y' at end
    assert vowels_count("shy") == 1     # 'y' at end
    assert vowels_count("gray") == 2    # 'a', 'y' at end
    
    # Long words
    assert vowels_count("extraordinary") == 6  # 'e', 'a', 'o', 'i', 'a', 'y' at end
    assert vowels_count("Constantinople") == 5  # 'o', 'a', 'i', 'o', 'e'
    
    print("All test cases passed!")


# Run the tests
if __name__ == "__main__":
    test_vowels_count()