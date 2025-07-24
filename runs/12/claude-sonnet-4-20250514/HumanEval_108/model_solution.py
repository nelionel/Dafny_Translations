def count_nums(arr):
    """
    Write a function count_nums which takes an array of integers and returns
    the number of elements which has a sum of digits > 0.
    If a number is negative, then its first signed digit will be negative:
    e.g. -123 has signed digits -1, 2, and 3.
    >>> count_nums([]) == 0
    >>> count_nums([-1, 11, -11]) == 1
    >>> count_nums([1, 1, 2]) == 3
    """
    def sum_of_signed_digits(num):
        if num == 0:
            return 0
        
        # Convert to string to work with digits
        num_str = str(abs(num))
        digits = [int(d) for d in num_str]
        
        # If the original number was negative, make the first digit negative
        if num < 0:
            digits[0] = -digits[0]
        
        return sum(digits)
    
    count = 0
    for num in arr:
        if sum_of_signed_digits(num) > 0:
            count += 1
    
    return count