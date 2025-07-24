def tri(n):
    """Everyone knows Fibonacci sequence, it was studied deeply by mathematicians in 
    the last couple centuries. However, what people don't know is Tribonacci sequence.
    Tribonacci sequence is defined by the recurrence:
    tri(1) = 3
    tri(n) = 1 + n / 2, if n is even.
    tri(n) =  tri(n - 1) + tri(n - 2) + tri(n + 1), if n is odd.
    For example:
    tri(2) = 1 + (2 / 2) = 2
    tri(4) = 3
    tri(3) = tri(2) + tri(1) + tri(4)
           = 2 + 3 + 3 = 8 
    You are given a non-negative integer number n, you have to a return a list of the 
    first n + 1 numbers of the Tribonacci sequence.
    Examples:
    tri(3) = [1, 3, 2, 8]
    """
    if n == 0:
        return [1]
    
    # Initialize the result list
    result = [0] * (n + 1)
    
    # Base cases
    result[0] = 1  # tri(0) = 1 (implied from the example)
    if n >= 1:
        result[1] = 3  # tri(1) = 3
    
    # Calculate even positions first (they don't depend on odd positions)
    for i in range(2, n + 1, 2):  # Even positions
        result[i] = 1 + i // 2
    
    # Calculate odd positions (they depend on even positions and previous odd positions)
    for i in range(3, n + 1, 2):  # Odd positions starting from 3
        result[i] = result[i - 1] + result[i - 2] + result[i + 1]
    
    return result