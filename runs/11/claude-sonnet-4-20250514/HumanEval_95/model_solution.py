def check_dict_case(dict):
    """
    Given a dictionary, return True if all keys are strings in lower 
    case or all keys are strings in upper case, else return False.
    The function should return False is the given dictionary is empty.
    """
    # Return False if dictionary is empty
    if not dict:
        return False
    
    # Check if all keys are strings
    if not all(isinstance(key, str) for key in dict.keys()):
        return False
    
    # Get all keys as a list
    keys = list(dict.keys())
    
    # Check if all keys are lowercase
    all_lower = all(key.islower() for key in keys)
    
    # Check if all keys are uppercase  
    all_upper = all(key.isupper() for key in keys)
    
    # Return True if all keys are either all lowercase or all uppercase
    return all_lower or all_upper