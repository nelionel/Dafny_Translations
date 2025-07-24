def fibfib(n: int):
    """The FibFib number sequence is a sequence similar to the Fibbonacci sequnece that's defined as follows:
    fibfib(0) == 0
    fibfib(1) == 0
    fibfib(2) == 1
    fibfib(n) == fibfib(n-1) + fibfib(n-2) + fibfib(n-3).
    Please write a function to efficiently compute the n-th element of the fibfib number sequence.
    >>> fibfib(1)
    0
    >>> fibfib(5)
    4
    >>> fibfib(8)
    24
    """
    # Handle base cases
    if n == 0:
        return 0
    elif n == 1:
        return 0
    elif n == 2:
        return 1
    
    # Use dynamic programming for efficiency
    # Keep track of the last three values
    a, b, c = 0, 0, 1  # fibfib(0), fibfib(1), fibfib(2)
    
    # Compute iteratively from 3 to n
    for i in range(3, n + 1):
        next_val = a + b + c
        a, b, c = b, c, next_val
    
    return c