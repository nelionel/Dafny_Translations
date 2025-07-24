def specialFilter(nums):
    """Write a function that takes an array of numbers as input and returns 
    the number of elements in the array that are greater than 10 and both 
    first and last digits of a number are odd (1, 3, 5, 7, 9).
    For example:
    specialFilter([15, -73, 14, -15]) => 1 
    specialFilter([33, -2, -3, 45, 21, 109]) => 2
    """
    count = 0
    odd_digits = {'1', '3', '5', '7', '9'}
    
    for num in nums:
        # Check if number is greater than 10
        if num > 10:
            # Convert to string to easily access first and last digits
            # Use absolute value to handle the digits properly
            str_num = str(abs(num))
            
            # Check if both first and last digits are odd
            first_digit = str_num[0]
            last_digit = str_num[-1]
            
            if first_digit in odd_digits and last_digit in odd_digits:
                count += 1
    
    return count