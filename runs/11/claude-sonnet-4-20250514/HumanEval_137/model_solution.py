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
    
    def to_numeric(value):
        """Convert value to numeric, handling comma as decimal separator"""
        if isinstance(value, str):
            # Replace comma with dot for proper float conversion
            return float(value.replace(',', '.'))
        return float(value)
    
    # Convert both values to numeric for comparison
    num_a = to_numeric(a)
    num_b = to_numeric(b)
    
    # Compare and return original value or None
    if num_a > num_b:
        return a
    elif num_b > num_a:
        return b
    else:
        return None