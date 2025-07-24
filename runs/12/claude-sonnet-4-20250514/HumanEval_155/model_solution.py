def even_odd_count(num):
    """Given an integer. return a tuple that has the number of even and odd digits respectively.

     Example:
        even_odd_count(-12) ==> (1, 1)
        even_odd_count(123) ==> (1, 2)
    """
    # Convert to string and remove negative sign if present
    num_str = str(abs(num))
    
    even_count = 0
    odd_count = 0
    
    # Iterate through each digit
    for digit_char in num_str:
        digit = int(digit_char)
        if digit % 2 == 0:
            even_count += 1
        else:
            odd_count += 1
    
    return (even_count, odd_count)