def sort_array(arr):
    """
    In this Kata, you have to sort an array of non-negative integers according to
    number of ones in their binary representation in ascending order.
    For similar number of ones, sort based on decimal value.
    """
    def count_ones(n):
        # Handle negative numbers by taking absolute value
        return bin(abs(n)).count('1')
    
    # Sort by (number of ones in binary, decimal value)
    return sorted(arr, key=lambda x: (count_ones(x), x))