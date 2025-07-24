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
    # Check if there are any whitespaces
    if ' ' in txt:
        return txt.split()
    
    # Check if there are any commas
    elif ',' in txt:
        return txt.split(',')
    
    # Count lowercase letters with odd positions in alphabet
    else:
        count = 0
        for char in txt:
            if char.islower():
                # Calculate position in alphabet (a=0, b=1, etc.)
                position = ord(char) - ord('a')
                # Check if position is odd
                if position % 2 == 1:
                    count += 1
        return count