from typing import List


def separate_paren_groups(paren_string: str) -> List[str]:
    """ Input to this function is a string containing multiple groups of nested parentheses. Your goal is to
    separate those group into separate strings and return the list of those.
    Separate groups are balanced (each open brace is properly closed) and not nested within each other
    Ignore any spaces in the input string.
    >>> separate_paren_groups('( ) (( )) (( )( ))')
    ['()', '(())', '(()())']
    """
    result = []
    current_group = ""
    level = 0
    
    for char in paren_string:
        if char == ' ':
            continue  # Ignore spaces
        
        current_group += char
        
        if char == '(':
            level += 1
        elif char == ')':
            level -= 1
            
        # When level reaches 0, we've found a complete balanced group
        if level == 0:
            result.append(current_group)
            current_group = ""
    
    return result