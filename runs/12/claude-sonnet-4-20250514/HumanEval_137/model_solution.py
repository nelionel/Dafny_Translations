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
    def to_numeric(val):
        """Convert input to numeric value for comparison"""
        if isinstance(val, (int, float)):
            return float(val)
        elif isinstance(val, str):
            # Replace comma with dot and convert to float
            return float(val.replace(',', '.'))
        else:
            raise ValueError("Invalid input type")
    
    # Convert both to numeric values for comparison
    num_a = to_numeric(a)
    num_b = to_numeric(b)
    
    # Compare and return the original variable
    if num_a > num_b:
        return a
    elif num_b > num_a:
        return b
    else:
        return None