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
    shift = 2 * 2  # two multiplied to two places = 4
    
    for char in s:
        if char.isalpha():
            # Handle both uppercase and lowercase
            if char.islower():
                # Shift lowercase letters
                shifted = chr((ord(char) - ord('a') + shift) % 26 + ord('a'))
            else:
                # Shift uppercase letters
                shifted = chr((ord(char) - ord('A') + shift) % 26 + ord('A'))
            result += shifted
        else:
            # Non-alphabetic characters remain unchanged
            result += char
    
    return result