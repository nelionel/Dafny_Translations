def check_dict_case(dict):
    """
    Given a dictionary, return True if all keys are strings in lower 
    case or all keys are strings in upper case, else return False.
    The function should return False is the given dictionary is empty.
    """
    # Check if dictionary is empty
    if not dict:
        return False
    
    # Check if all keys are strings
    for key in dict.keys():
        if not isinstance(key, str):
            return False
    
    # Check if all keys are lowercase or all keys are uppercase
    all_lower = all(key.islower() for key in dict.keys())
    all_upper = all(key.isupper() for key in dict.keys())
    
    return all_lower or all_upper