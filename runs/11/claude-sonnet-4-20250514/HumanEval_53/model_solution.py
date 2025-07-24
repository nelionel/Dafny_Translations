def add(x: int, y: int) -> int:
    """Add two numbers x and y
    >>> add(2, 3)
    5
    >>> add(5, 7)
    12
    """
    return x + y

# Test the function with doctests
if __name__ == "__main__":
    import doctest
    doctest.testmod()