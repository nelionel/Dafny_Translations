def find_zero(xs: list):
    """ xs are coefficients of a polynomial.
    find_zero find x such that poly(x) = 0.
    find_zero returns only only zero point, even if there are many.
    Moreover, find_zero only takes list xs having even number of coefficients
    and largest non zero coefficient as it guarantees
    a solution.
    >>> round(find_zero([1, 2]), 2) # f(x) = 1 + 2x
    -0.5
    >>> round(find_zero([-6, 11, -6, 1]), 2) # (x - 1) * (x - 2) * (x - 3) = -6 + 11x - 6x^2 + x^3
    1.0
    """
    # Calculate derivative coefficients
    # If f(x) = a0 + a1*x + a2*x^2 + ... + an*x^n
    # Then f'(x) = a1 + 2*a2*x + 3*a3*x^2 + ... + n*an*x^(n-1)
    derivative_xs = [i * coeff for i, coeff in enumerate(xs)][1:]
    
    # Initial guess
    x = 0.0
    
    # Newton's method: x_{n+1} = x_n - f(x_n)/f'(x_n)
    for _ in range(1000):  # Maximum iterations to prevent infinite loop
        fx = poly(xs, x)
        
        # Check if we found a root (close enough to zero)
        if abs(fx) < 1e-10:
            break
            
        # Calculate derivative at current point
        fpx = poly(derivative_xs, x)
        
        # Avoid division by zero
        if abs(fpx) < 1e-10:
            break
            
        # Newton's method update
        x = x - fx / fpx
    
    return x