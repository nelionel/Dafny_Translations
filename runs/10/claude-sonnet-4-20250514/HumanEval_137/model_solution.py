def compare_one(a, b):
    """
    Create a function that takes integers, floats, or strings representing
    real numbers, and returns the larger variable in its given variable type.
    Return None if the values are equal.
    Note: If a real number is represented as a string, the floating point might be . or ,

    compare_one(1, 2.5) ➞ 2.5
    compare_one(1, "2,3") ➞ "2,3"
    compare_one("5,1", "6") ➞ "6"
    compare_one("1", 1) ➞ None
    """
    
    def convert_to_number(value):
        """Convert a value to its numerical representation for comparison"""
        if isinstance(value, (int, float)):
            return float(value)
        elif isinstance(value, str):
            # Replace comma with dot for proper float conversion
            return float(value.replace(',', '.'))
        else:
            raise ValueError("Unsupported type")
    
    # Convert both values to numbers for comparison
    num_a = convert_to_number(a)
    num_b = convert_to_number(b)
    
    # Compare the numerical values
    if num_a > num_b:
        return a
    elif num_b > num_a:
        return b
    else:
        return None