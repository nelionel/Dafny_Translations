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
    def poly_derivative(xs: list, x: float):
        """Calculate the derivative of polynomial at point x"""
        return sum([i * coeff * math.pow(x, i-1) for i, coeff in enumerate(xs) if i > 0])
    
    # Newton's method implementation
    x = 0.0  # Initial guess
    tolerance = 1e-10
    max_iterations = 1000
    
    for _ in range(max_iterations):
        fx = poly(xs, x)
        if abs(fx) < tolerance:
            return x
        
        fpx = poly_derivative(xs, x)
        if abs(fpx) < tolerance:
            # If derivative is too small, try a different starting point
            x = x + 1.0
            continue
        
        x_new = x - fx / fpx
        
        if abs(x_new - x) < tolerance:
            return x_new
        
        x = x_new
    
    return x