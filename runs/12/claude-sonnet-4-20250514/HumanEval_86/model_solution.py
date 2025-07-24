def anti_shuffle(s):
    """
    Write a function that takes a string and returns an ordered version of it.
    Ordered version of string, is a string where all words (separated by space)
    are replaced by a new word where all the characters arranged in
    ascending order based on ascii value.
    Note: You should keep the order of words and blank spaces in the sentence.

    For example:
    anti_shuffle('Hi') returns 'Hi'
    anti_shuffle('hello') returns 'ehllo'
    anti_shuffle('Hello World!!!') returns 'Hello !!!Wdlor'
    """
    # Split the string by spaces to get individual words
    words = s.split(' ')
    
    # Sort characters in each word and collect results
    result = []
    for word in words:
        # Sort characters in the word by ASCII value
        sorted_word = ''.join(sorted(word))
        result.append(sorted_word)
    
    # Join the words back with spaces
    return ' '.join(result)