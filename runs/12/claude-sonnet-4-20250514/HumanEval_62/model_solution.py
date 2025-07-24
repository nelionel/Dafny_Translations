def derivative(xs: list):
    """ xs represent coefficients of a polynomial.
    xs[0] + xs[1] * x + xs[2] * x^2 + ....
     Return derivative of this polynomial in the same form.
    >>> derivative([3, 1, 2, 4, 5])
    [1, 4, 12, 20]
    >>> derivative([1, 2, 3])
    [2, 6]
    """
    # The derivative of a constant is 0, so we skip xs[0]
    # For xs[i], the power is i, so derivative coefficient is i * xs[i]
    result = []
    for i in range(1, len(xs)):
        result.append(i * xs[i])
    return result