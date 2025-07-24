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
    
    # We need to compute extra terms to handle the dependency tri(n+1) for odd n
    # We'll compute up to n+1, or n+2 if n is odd to ensure we have tri(n+1)
    max_needed = n + 2
    result = [0] * max_needed
    
    # First, compute all even-indexed terms since they don't depend on other terms
    for i in range(0, max_needed, 2):
        result[i] = 1 + i // 2
    
    # Handle the special case tri(1) = 3
    if max_needed > 1:
        result[1] = 3
    
    # Then compute odd-indexed terms (starting from 3)
    for i in range(3, max_needed, 2):
        result[i] = result[i-1] + result[i-2] + result[i+1]
    
    # Return only the first n+1 terms as requested
    return result[:n+1]