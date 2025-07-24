def make_palindrome(string: str) -> str:
    """ Find the shortest palindrome that begins with a supplied string.
    Algorithm idea is simple:
    - Find the longest postfix of supplied string that is a palindrome.
    - Append to the end of the string reverse of a string prefix that comes before the palindromic suffix.
    >>> make_palindrome('')
    ''
    >>> make_palindrome('cat')
    'catac'
    >>> make_palindrome('cata')
    'catac'
    """
    if not string:
        return ''
    
    # Find the longest palindromic suffix by checking from left to right
    for i in range(len(string)):
        suffix = string[i:]
        if is_palindrome(suffix):
            # Found the longest palindromic suffix
            # Get the prefix that comes before this suffix
            prefix = string[:i]
            # Append the reverse of the prefix to the original string
            return string + prefix[::-1]
    
    # This should never be reached since a single character is always a palindrome
    return string