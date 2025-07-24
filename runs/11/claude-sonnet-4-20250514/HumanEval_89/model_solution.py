def encrypt(s):
    """Create a function encrypt that takes a string as an argument and
    returns a string encrypted with the alphabet being rotated. 
    The alphabet should be rotated in a manner such that the letters 
    shift down by two multiplied to two places.
    For example:
    encrypt('hi') returns 'lm'
    encrypt('asdfghjkl') returns 'ewhjklnop'
    encrypt('gf') returns 'kj'
    encrypt('et') returns 'ix'
    """
    result = ""
    
    for char in s:
        if char.isalpha():
            # Check if uppercase or lowercase
            if char.isupper():
                # Shift by 4 positions for uppercase letters
                shifted = chr((ord(char) - ord('A') + 4) % 26 + ord('A'))
            else:
                # Shift by 4 positions for lowercase letters
                shifted = chr((ord(char) - ord('a') + 4) % 26 + ord('a'))
            result += shifted
        else:
            # Non-alphabetic characters remain unchanged
            result += char
    
    return result