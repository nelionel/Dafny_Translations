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
    >>> vowels_count("")
    0
    >>> vowels_count("bcdfg")
    0
    >>> vowels_count("aeiou")
    5
    >>> vowels_count("happy")
    2
    >>> vowels_count("cry")
    1
    >>> vowels_count("rhythm")
    0
    >>> vowels_count("by")
    1
    >>> vowels_count("my")
    1
    >>> vowels_count("gym")
    0
    >>> vowels_count("yesterday")
    4
    >>> vowels_count("Y")
    1
    >>> vowels_count("y")
    1
    >>> vowels_count("a")
    1
    >>> vowels_count("b")
    0
    >>> vowels_count("AEIOUaeiou")
    10
    >>> vowels_count("xyz")
    0
    >>> vowels_count("fly")
    1
    >>> vowels_count("python")
    1
    >>> vowels_count("PYTHON")
    1
    """
    if not s:  # Handle empty string
        return 0
    
    vowels = 'aeiouAEIOU'
    count = 0
    
    for i, char in enumerate(s):
        if char in vowels:
            count += 1
        elif char.lower() == 'y' and i == len(s) - 1:
            count += 1
    
    return count