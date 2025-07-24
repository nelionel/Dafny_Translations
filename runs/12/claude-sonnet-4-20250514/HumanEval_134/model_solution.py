def check_if_last_char_is_a_letter(txt):
    '''
    Create a function that returns True if the last character
    of a given string is an alphabetical character and is not
    a part of a word, and False otherwise.
    Note: "word" is a group of characters separated by space.

    Examples:
    check_if_last_char_is_a_letter("apple pie") ➞ False
    check_if_last_char_is_a_letter("apple pi e") ➞ True
    check_if_last_char_is_a_letter("apple pi e ") ➞ False
    check_if_last_char_is_a_letter("") ➞ False 
    '''
    # Check if string is empty
    if not txt:
        return False
    
    # Get the last character
    last_char = txt[-1]
    
    # Check if last character is alphabetical
    if not last_char.isalpha():
        return False
    
    # If string has only one character and it's a letter
    if len(txt) == 1:
        return True
    
    # Check if the character before the last character is a space
    # This means the last character is not part of a word
    if txt[-2] == ' ':
        return True
    
    return False