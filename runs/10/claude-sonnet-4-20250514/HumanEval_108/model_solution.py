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
    def digit_sum(n):
        if n == 0:
            return 0
        
        # Convert to string to easily work with digits
        s = str(abs(n))
        
        # Calculate sum of digits
        total = sum(int(digit) for digit in s)
        
        # If original number was negative, make first digit negative
        if n < 0:
            first_digit = int(s[0])
            # Subtract twice the first digit to make it negative
            # (since we already added it once as positive)
            total = total - 2 * first_digit
        
        return total
    
    count = 0
    for num in arr:
        if digit_sum(num) > 0:
            count += 1
    
    return count