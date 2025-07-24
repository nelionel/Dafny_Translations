def split_words(txt):
    '''
    Given a string of words, return a list of words split on whitespace, if no whitespaces exists in the text you
    should split on commas ',' if no commas exists you should return the number of lower-case letters with odd order in the
    alphabet, ord('a') = 0, ord('b') = 1, ... ord('z') = 25
    Examples
    split_words("Hello world!") ➞ ["Hello", "world!"]
    split_words("Hello,world!") ➞ ["Hello", "world!"]
    split_words("abcdef") == 3 
    '''
    # First, try to split on whitespace
    if ' ' in txt:
        return txt.split()
    
    # If no whitespace, try to split on commas
    if ',' in txt:
        return txt.split(',')
    
    # If neither whitespace nor commas, count lowercase letters with odd positions
    count = 0
    for char in txt:
        if char.islower() and char.isalpha():
            # Calculate position: a=0, b=1, c=2, etc.
            position = ord(char) - ord('a')
            # Check if position is odd (1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25)
            if position % 2 == 1:
                count += 1
    
    return count