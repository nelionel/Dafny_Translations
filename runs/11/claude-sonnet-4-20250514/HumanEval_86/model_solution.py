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
    
    # Process each word by sorting its characters
    result_words = []
    for word in words:
        # Sort the characters in the word based on ASCII values
        sorted_word = ''.join(sorted(word))
        result_words.append(sorted_word)
    
    # Join the words back with spaces
    return ' '.join(result_words)