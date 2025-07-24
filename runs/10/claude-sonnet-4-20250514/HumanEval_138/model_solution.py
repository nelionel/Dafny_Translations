def is_equal_to_sum_even(n):
    """Evaluate whether the given number n can be written as the sum of exactly 4 positive even numbers
    Example
    is_equal_to_sum_even(4) == False
    is_equal_to_sum_even(6) == False
    is_equal_to_sum_even(8) == True
    """
    # A number can be written as sum of 4 positive even numbers if:
    # 1. It's even (sum of even numbers is always even)
    # 2. It's at least 8 (minimum sum: 2+2+2+2 = 8)
    return n % 2 == 0 and n >= 8