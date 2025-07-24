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
    shift = 4  # 2 * 2 = 4
    
    for char in s:
        if char.islower():
            # Shift lowercase letters by 4, wrapping around if necessary
            shifted = (ord(char) - ord('a') + shift) % 26
            result += chr(shifted + ord('a'))
        elif char.isupper():
            # Shift uppercase letters by 4, wrapping around if necessary
            shifted = (ord(char) - ord('A') + shift) % 26
            result += chr(shifted + ord('A'))
        else:
            # Non-alphabetic characters remain unchanged
            result += char
    
    return result