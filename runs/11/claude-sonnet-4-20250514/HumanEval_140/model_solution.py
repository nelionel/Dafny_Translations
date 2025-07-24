def fix_spaces(text):
    """
    Given a string text, replace all spaces in it with underscores, 
    and if a string has more than 2 consecutive spaces, 
    then replace all consecutive spaces with - 
    
    fix_spaces("Example") == "Example"
    fix_spaces("Example 1") == "Example_1"
    fix_spaces(" Example 2") == "_Example_2"
    fix_spaces(" Example   3") == "_Example-3"
    """
    result = ""
    i = 0
    
    while i < len(text):
        if text[i] == ' ':
            # Count consecutive spaces
            space_count = 0
            j = i
            while j < len(text) and text[j] == ' ':
                space_count += 1
                j += 1
            
            # Replace based on count
            if space_count > 2:
                result += '-'
            else:
                result += '_' * space_count
            
            i = j  # Skip all the spaces we just processed
        else:
            result += text[i]
            i += 1
    
    return result