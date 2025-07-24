def digits(n):
    """Given a positive integer n, return the product of the odd digits.
    Return 0 if all digits are even.
    For example:
    digits(1)  == 1
    digits(4)  == 0
    digits(235) == 15
    """
    product = 1
    has_odd_digit = False
    
    # Extract each digit
    while n > 0:
        digit = n % 10
        if digit % 2 == 1:  # Check if digit is odd
            product *= digit
            has_odd_digit = True
        n //= 10
    
    # Return 0 if no odd digits were found, otherwise return the product
    return product if has_odd_digit else 0