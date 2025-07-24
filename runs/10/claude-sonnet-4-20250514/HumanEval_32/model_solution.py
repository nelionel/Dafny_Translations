import math


def poly(xs: list, x: float):
    """
    Evaluates polynomial with coefficients xs at point x.
    return xs[0] + xs[1] * x + xs[1] * x^2 + .... xs[n] * x^n
    """
    return sum([coeff * math.pow(x, i) for i, coeff in enumerate(xs)])


def poly_derivative(xs: list, x: float):
    """
    Evaluates the derivative of polynomial with coefficients xs at point x.
    """
    return sum([i * coeff * math.pow(x, i - 1) for i, coeff in enumerate(xs) if i > 0])


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
    # Use Newton-Raphson method to find zero
    # Start with an initial guess
    x = 1.0
    
    # Newton-Raphson iteration
    for _ in range(1000):  # Maximum iterations to prevent infinite loop
        fx = poly(xs, x)
        fpx = poly_derivative(xs, x)
        
        # Check if we found the zero (within tolerance)
        if abs(fx) < 1e-10:
            break
            
        # Avoid division by zero
        if abs(fpx) < 1e-10:
            break
            
        # Newton-Raphson update: x_new = x - f(x)/f'(x)
        x_new = x - fx / fpx
        
        # Check for convergence
        if abs(x_new - x) < 1e-10:
            break
            
        x = x_new
    
    return x