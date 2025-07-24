def histogram(test):
    """Given a string representing a space separated lowercase letters, return a dictionary
    of the letter with the most repetition and containing the corresponding count.
    If several letters have the same occurrence, return all of them.
    
    Example:
    histogram('a b c') == {'a': 1, 'b': 1, 'c': 1}
    histogram('a b b a') == {'a': 2, 'b': 2}
    histogram('a b c a b') == {'a': 2, 'b': 2}
    histogram('b b b b a') == {'b': 4}
    histogram('') == {}

    """
    # Handle empty string
    if not test.strip():
        return {}
    
    # Split the string by spaces to get individual letters
    letters = test.split()
    
    # Count frequency of each letter
    letter_counts = {}
    for letter in letters:
        letter_counts[letter] = letter_counts.get(letter, 0) + 1
    
    # Find the maximum frequency
    max_count = max(letter_counts.values())
    
    # Return dictionary with all letters that have maximum frequency
    result = {}
    for letter, count in letter_counts.items():
        if count == max_count:
            result[letter] = count
    
    return result