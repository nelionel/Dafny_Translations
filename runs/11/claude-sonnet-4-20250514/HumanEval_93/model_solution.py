def encode(message):
    """
    Write a function that takes a message, and encodes in such a 
    way that it swaps case of all letters, replaces all vowels in 
    the message with the letter that appears 2 places ahead of that 
    vowel in the english alphabet. 
    Assume only letters. 
    
    Examples:
    >>> encode('test')
    'TGST'
    >>> encode('This is a message')
    'tHKS KS C MGSSCGG'
    """
    vowels = 'aeiouAEIOU'
    vowel_mapping = {
        'a': 'c', 'e': 'g', 'i': 'k', 'o': 'q', 'u': 'w',
        'A': 'C', 'E': 'G', 'I': 'K', 'O': 'Q', 'U': 'W'
    }
    
    result = []
    
    for char in message:
        if char in vowels:
            # Replace vowel with letter 2 places ahead, then swap case
            new_char = vowel_mapping[char]
            result.append(new_char.swapcase())
        elif char.isalpha():
            # Just swap case for consonants
            result.append(char.swapcase())
        else:
            # Keep non-alphabetic characters as is
            result.append(char)
    
    return ''.join(result)