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
    
    # For n >= 3, use iterative approach with sliding window
    # Keep track of the last 3 values: [n-3, n-2, n-1]
    prev3, prev2, prev1 = 0, 0, 1
    
    for i in range(3, n + 1):
        current = prev1 + prev2 + prev3
        # Slide the window: shift all values
        prev3, prev2, prev1 = prev2, prev1, current
    
    return prev1