def is_palindrome(text: str):
    """
    Checks if given string is a palindrome
    >>> is_palindrome('')
    True
    >>> is_palindrome('aba')
    True
    >>> is_palindrome('aaaaa')
    True
    >>> is_palindrome('zbcd')
    False
    """
    # Convert to lowercase to handle case-insensitive comparison
    text = text.lower()
    
    # Compare the string with its reverse
    return text == text[::-1]